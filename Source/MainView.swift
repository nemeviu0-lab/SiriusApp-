import SwiftUI

struct SiriusMainView: View {
    @State private var message: String = ""
    @State private var chatHistory: [ChatMessage] = []

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("SIRIUS KERNEL")
                    .font(.custom("Courier", size: 24))
                    .foregroundColor(.cyan)
                    .shadow(color: .cyan, radius: 10)
                    .padding()

                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(chatHistory) { msg in
                            HStack {
                                if msg.isUser { Spacer() }
                                Text(msg.text)
                                    .padding(10)
                                    .background(msg.isUser ? Color.blue.opacity(0.3) : Color.cyan.opacity(0.2))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .border(Color.cyan, width: 0.5)
                                if !msg.isUser { Spacer() }
                            }
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)

                HStack {
                    TextField("Sincronizar...", text: $message)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(10)
                        .background(Color.black)
                        .foregroundColor(.cyan)
                        .border(Color.cyan, width: 1)
                        .cornerRadius(5)
                    
                    Button(action: sendMessage) {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.cyan)
                            .cornerRadius(5)
                    }
                }
                .padding()
            }
        }
    }

    func sendMessage() {
        if !message.isEmpty {
            chatHistory.append(ChatMessage(text: message, isUser: true))
            // Lógica de conexão com o núcleo do PC entraria aqui
            chatHistory.append(ChatMessage(text: "Sincronizando com o Núcleo...", isUser: false))
            message = ""
        }
    }
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}
