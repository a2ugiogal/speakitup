package _00_init.util;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class SendEmail extends Thread {
	private String[] reciver;
	private String subject;
	private String content;
	private String attachmentLocation;

	public SendEmail(String[] reciver, String subject, String content, String attachmentLocation) {
		super();
		this.reciver = reciver;
		this.subject = subject;
		this.content = content;
		this.attachmentLocation = attachmentLocation;
	}

	public void run() {
		for (String to : reciver) {
//			 Recipient's email ID needs to be mentioned.
//			String to = "";
			// Sender's email ID needs to be mentioned
			String from = GlobalService.NOREPLY_EMAIL;
			// Assuming you are sending email from through gmails smtp
			String host = "smtp.gmail.com";
			// Get system properties
			Properties properties = System.getProperties();
			// Setup mail server
			properties.put("mail.smtp.host", host);
			properties.put("mail.smtp.port", "465");
			properties.put("mail.smtp.ssl.enable", "true");
			properties.put("mail.smtp.auth", "true");
			// Get the Session object.// and pass username and password
			Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(GlobalService.NOREPLY_EMAIL,
							GlobalService.NOREPLY_EMAIL_PASSWORD);
				}
			});
			// Used to debug SMTP issues
			session.setDebug(false);
			try {
				// Create a default MimeMessage object.
				MimeMessage message = new MimeMessage(session);
				// Set From: header field of the header.
				message.setFrom(new InternetAddress(from, GlobalService.SYSTEM_NAME));  //寄件者
				// Set To: header field of the header.
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));	//收件者
				// Set Subject: header field
				message.setSubject(subject);
				if (attachmentLocation.trim().length() != 0) {
					// Set attachment
					Multipart multipart = new MimeMultipart();
					MimeBodyPart attachmentPart = new MimeBodyPart();
					MimeBodyPart htmlPart = new MimeBodyPart();
					try {
						File f = new File(attachmentLocation);
						attachmentPart.attachFile(f);
						htmlPart.setContent(content, "text/html;charset=utf-8");
						multipart.addBodyPart(htmlPart);
						multipart.addBodyPart(attachmentPart);
						message.setContent(multipart);
					} catch (IOException e) {
						e.printStackTrace();
					}
				} else {
					// Set the actual message
					message.setText("This is actual message");
					// Send the actual HTML message.
					message.setContent(content, "text/html;charset=utf-8");
				}
				// Set Date:
				message.setSentDate(new Date());
				System.out.println("sending...");
				// Send message
				Transport.send(message);
				System.out.println("Sent message successfully....");
			} catch (MessagingException e) {
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
	}
}
