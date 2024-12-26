import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Calendar;
import java.util.GregorianCalendar;

@WebServlet("/calendar")
public class CalendarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Initialize calendar with current date.
        Calendar calendar = new GregorianCalendar();

        try {
            // Get parameters from the request and set them on the calendar if provided.
            String yearParam = request.getParameter("year");
            String monthParam = request.getParameter("month");

            // Validate and parse year parameter.
            if (yearParam != null && !yearParam.isEmpty()) {
                int year = Integer.parseInt(yearParam);
                if (year < 1 || year > 9999) { // Assuming a reasonable range for years.
                    throw new IllegalArgumentException("Year must be between 1 and 9999.");
                }
                calendar.set(Calendar.YEAR, year);
            }

            // Validate and parse month parameter.
            if (monthParam != null && !monthParam.isEmpty()) {
                int month = Integer.parseInt(monthParam);
                if (month < 1 || month > 12) {
                    throw new IllegalArgumentException("Month must be between 1 and 12.");
                }
                calendar.set(Calendar.MONTH, month - 1); // Months are 0-based in Java Calendar
            }

            // Reset day to the first of the selected month.
            calendar.set(Calendar.DAY_OF_MONTH, 1);

            // Pre-compute required calendar information and set as attributes for JSP.
            request.setAttribute("calendar", calendar);
            request.setAttribute("year", calendar.get(Calendar.YEAR));
            request.setAttribute("month", calendar.get(Calendar.MONTH) + 1); // Convert back to 1-based
            request.setAttribute("firstDayOfWeek", calendar.get(Calendar.DAY_OF_WEEK));
            request.setAttribute("daysInMonth", calendar.getActualMaximum(Calendar.DAY_OF_MONTH));

            // Calculate previous month's days count
            Calendar prevMonthCal = (Calendar) calendar.clone();
            prevMonthCal.add(Calendar.MONTH, -1);
            request.setAttribute("prevMonthDays", prevMonthCal.getActualMaximum(Calendar.DAY_OF_MONTH));

        } catch (NumberFormatException e) {
            // Handle non-integer input.
            request.setAttribute("errorMessage", "无法加载日历，请输入有效的数字作为年份和月份。");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        } catch (IllegalArgumentException e) {
            // Handle out-of-range or other invalid inputs.
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Forward to the JSP page for rendering.
        request.getRequestDispatcher("calendarView.jsp").forward(request, response);
    }
}