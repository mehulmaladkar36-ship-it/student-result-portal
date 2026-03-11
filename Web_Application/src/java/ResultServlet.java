
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ResultServlet")
public class ResultServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String roll = request.getParameter("rollno");
        String pass = request.getParameter("password");
        String userCaptcha = request.getParameter("captcha");
        String generatedCaptcha = request.getParameter("generatedCaptcha");

        // CAPTCHA CHECK
        if (!userCaptcha.equals(generatedCaptcha)) {
            request.setAttribute("error", "⚠ Invalid Captcha");
            RequestDispatcher rd = request.getRequestDispatcher("/result.jsp");
            rd.forward(request, response);
            return;
        }

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/studentportal",
                    "root",
                    "1234"
            );

            PreparedStatement ps = con.prepareStatement(
                    "SELECT result_pdf FROM students WHERE rollno=? AND password=?"
            );

            ps.setString(1, roll);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String pdf = rs.getString("result_pdf");

                response.sendRedirect(request.getContextPath() + "/results/" + pdf);

            } else {

                request.setAttribute("error", "⚠ Invalid Username or Password");
                RequestDispatcher rd = request.getRequestDispatcher("/result.jsp");
                rd.forward(request, response);
                return;
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}