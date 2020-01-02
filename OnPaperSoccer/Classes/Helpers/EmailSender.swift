import Foundation

protocol EmailSender {
    func sendMail(to emailAddress: String)
}

final class DefaultEmailSender: EmailSender {
    func sendMail(to emailAddress: String) {
    }
}
