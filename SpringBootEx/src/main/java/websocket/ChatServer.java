package websocket;

import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import java.io.*;
import java.net.*;
import java.util.*;
import java.util.concurrent.CopyOnWriteArrayList;

@Component
public class ChatServer implements Runnable {

    private static final int PORT = 23456;
    private ServerSocket serverSocket;
    private final List<Socket> clients = new CopyOnWriteArrayList<>();
    private boolean running = false;

    @EventListener(ContextRefreshedEvent.class)
    public void startServer() {
        if (!running) {
            new Thread(this).start();
            running = true;
            System.out.println("✅ ChatServer starting on port " + PORT);
        } else {
            System.out.println("⚠️ ChatServer already running. Skipping re-initialization.");
        }
    }

    @Override
    public void run() {
        try {
            serverSocket = new ServerSocket(PORT);
            System.out.println("✅ ChatServer started on port " + PORT);

            while (true) {
                Socket clientSocket = serverSocket.accept();
                clients.add(clientSocket);
                new Thread(new ClientHandler(clientSocket)).start();
            }
        } catch (BindException e) {
            System.err.println("🚫 포트 " + PORT + "는 이미 사용 중입니다. ChatServer는 이미 실행된 상태일 수 있습니다.");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private class ClientHandler implements Runnable {
        private final Socket socket;
        private BufferedReader in;

        public ClientHandler(Socket socket) {
            this.socket = socket;
        }

        public void run() {
            try {
                in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                String message;
                while ((message = in.readLine()) != null) {
                    broadcastMessage(message);
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                clients.remove(socket);
                try {
                    socket.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        private void broadcastMessage(String message) {
            for (Socket client : clients) {
                try {
                    PrintWriter out = new PrintWriter(client.getOutputStream(), true);
                    out.println(message);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
