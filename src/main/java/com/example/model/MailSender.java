package com.example.model;
import javax.mail.*;
import javax.mail.internet.*;

import java.util.*;

public class MailSender extends Thread {

    private final String senderEmailID = "mytravelbook21@gmail.com";
    private final String senderPassword = "travelbook1234";
    private final String emailSMTPserver = "smtp.gmail.com";
    private final String emailServerPort = "465";
    private String receiverEmailID = null;
    private String emailSubject = null;
    private String emailBody = null;


    public MailSender(String receiverEmailID, String emailSubject, String emailBody) {
        this.receiverEmailID = receiverEmailID;
        this.emailSubject = emailSubject;
        this.emailBody = emailBody;
    }
    @Override
    public void run() {
    	Properties props = new Properties();
        props.put("mail.smtp.user", senderEmailID);
        props.put("mail.smtp.host", emailSMTPserver);
        props.put("mail.smtp.port", emailServerPort);
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.socketFactory.port", emailServerPort);
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "false");
        SecurityManager security = System.getSecurityManager();
        try {
            Authenticator auth = new SMTPAuthenticator();
            Session session = Session.getInstance(props, auth);
            MimeMessage msg = new MimeMessage(session);
            msg.setText(emailBody);
            msg.setSubject(emailSubject);
            msg.setFrom(new InternetAddress(senderEmailID));
            msg.addRecipient(Message.RecipientType.TO,
                new InternetAddress(receiverEmailID));
            System.out.println(receiverEmailID);

            System.out.println("---Done---");
            Transport.send(msg);

            System.out.println("Message send Successfully:)");
        } catch (Exception mex) {
            mex.printStackTrace();
        }
    }

   


    private class SMTPAuthenticator extends javax.mail.Authenticator {

        public PasswordAuthentication getPasswordAuthentication() {

            return new PasswordAuthentication(senderEmailID, senderPassword);
        }
    }

}
