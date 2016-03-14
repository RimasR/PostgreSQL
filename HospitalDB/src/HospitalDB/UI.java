import java.sql.*;
import java.util.*;
import java.io.*;

public class UI
{
  public void runUI()
  {
    SQLDB db = new SQLDB();
    BufferedReader bufRead = new BufferedReader(new InputStreamReader(System.in));
    boolean valid = true;
    int choice = 0;
    while(valid)
    {
      try
      {
	//Runtime.getRuntime().exec("cls");
      	System.out.println(" 1 prideti nauja ligonine");
      	System.out.println(" 2 prideti nauja daktara");
      	System.out.println(" 3 prideti nauja pacienta");
      	System.out.println(" 4 prideti nauja gydyma");
      	System.out.println(" 5 istrinti norima gydyma");
      	System.out.println(" 6 keisti daktaro darboviete");
	System.out.println(" 7 pacientai ir ju gydymai");
      	System.out.println(" 8 iseiti is programos");
      	System.out.print("Your choise: ");
      	choice = Integer.parseInt(bufRead.readLine());
      

        switch (choice)
        {
                    case  1: addHospital(bufRead, db);
                              break;
                    case  2: addDoctor(bufRead, db);
                              break;
                    case  3: addPatient(bufRead, db);
                              break;
                    case  4: addTreatment(bufRead, db);
                              break;
                    case  5: deleteTreatment(bufRead, db);
                              break;
                    case  6: changeDoctorsHospotal(bufRead, db);
                              break;
		    case  7: showPatientsAndTreatments(bufRead, db);
			      break;
                    case  8: exit();
                              break;
                    default: System.out.println("Blogas pasirinkimas");
                              break;
        }
      }
      catch(IOException e)
      {
        System.out.println("Klaida skaitant duomenis");
	valid = false;
      }
      catch(NumberFormatException e)
      {
        System.out.println("Blogas formatas");
      }
    }

    db.closeConnection();
  }

  private void showPatientsAndTreatments(BufferedReader bufRead, SQLDB db)
  {
    try
    {
      List<List> patients = new LinkedList<List>();
      patients = db.queryDb("SELECT vardas, pavarde, diagnoze FROM rira1874.Pacientas, rira1874.Gydymai WHERE AK = Paciento_AK GROUP BY vardas, pavarde, diagnoze");
      for(int i = 0; i < patients.size(); i++)
      {
        System.out.println((String) patients.get(i).get(0) + " " + patients.get(i).get(1) + " " + patients.get(i).get(2));
      }

    }
    catch(Exception e)
    {
      System.out.println("Error: " + e.getMessage());
    }  
  }

  private void exit()
  {
    System.exit(0);
  }
  private void addHospital(BufferedReader bufRead, SQLDB db)
  {
    System.out.println("Iveskite pavadinima, adresa ir biudzeta");
    try
    {
      db.queryDb("INSERT INTO rira1874.Ligonine VALUES ('" + bufRead.readLine() + "','" + bufRead.readLine() + "'," + bufRead.readLine() + ")");
    }
    catch(Exception e)
    {
      System.out.println("Error: " + e.getMessage());
    }
  }

  private void addDoctor(BufferedReader bufRead, SQLDB db)
  {
    try
    {
      List<List> hospitals = new LinkedList<List>();
      hospitals = db.queryDb("SELECT * FROM rira1874.Ligonine");
      System.out.println("Galimos ligonines: ");
      for(int i = 0; i < hospitals.size(); i++)
      {
        System.out.println((String) hospitals.get(i).get(0));
      }
    }
    catch(Exception e)
    {
      System.out.println("Error: " + e.getMessage());
    }

    System.out.println("Iveskite AK, varda, pavarde, kvalifikacija ir atlyginima");
    try
    {
      db.queryDb("INSERT INTO rira1874.Gydytojas VALUES ('" + bufRead.readLine() + "','" + bufRead.readLine() + "','" + bufRead.readLine() + "','" + bufRead.readLine() + "'," + bufRead.readLine() + ")");
    }
    catch(Exception e)
    {
      System.out.println("Error: " + e.getMessage());
    }
  }

  private void addPatient(BufferedReader bufRead, SQLDB db)
  {
    System.out.println("Iveskite AK, varda, pavarde, gimimo metus(dd/mm/yyyy)");
    try
    {
      db.queryDb("INSERT INTO rira1874.Pacientas VALUES ('" + bufRead.readLine() + "','" + bufRead.readLine() + "','" + bufRead.readLine() + "','" + bufRead.readLine() + "')");
    }
    catch(Exception e)
    {
      System.out.println("Error: " + e.getMessage());
    }
  }

  private void addTreatment(BufferedReader bufRead, SQLDB db)
  {
    System.out.println("Iveskite Gydymo nr, Pradzios data, pabaigos data, skirtus vaistus, gydytojo ak, paciento ak ir diagnoze");
    try
    {
      db.queryDb("INSERT INTO rira1874.Gydymai VALUES (" + bufRead.readLine() + ",'" + bufRead.readLine() + "','" + bufRead.readLine() + "','" + bufRead.readLine() + "','" + bufRead.readLine() + "','" + bufRead.readLine() + "','" + bufRead.readLine() + "')");
    }
    catch(Exception e)
    {
      System.out.println("Error: " + e.getMessage());
    }
  }

  private void deleteTreatment(BufferedReader bufRead, SQLDB db)
  {
    List<List> treatments = new LinkedList<List>();
    try
    {
      treatments = db.queryDb("SELECT * FROM rira1874.Gydymai");
      System.out.println("Gydymai: ");
      for(int i = 0; i < treatments.size(); i++)
      {
        System.out.println((String) treatments.get(i).get(0) + " " + treatments.get(i).get(1) + " " + treatments.get(i).get(2)
                            + " " + treatments.get(i).get(3) + " " + treatments.get(i).get(4) + " " + treatments.get(i).get(5) + " " + treatments.get(i).get(6));
      }

      System.out.println("Iveskite gydymo numeri");
      treatments = db.queryDb("DELETE FROM rira1874.Gydymai WHERE Gydymo_nr = " + bufRead.readLine());
    }
    catch (Exception e)
    {
      System.out.println("Error: " + e.getMessage());
    }
  }

  private void changeDoctorsHospotal(BufferedReader bufRead, SQLDB db)
  {
    List<List> docs = new LinkedList<List>();
    List<List> hospitals = new LinkedList<List>();

    try
    {
      hospitals = db.queryDb("SELECT * FROM rira1874.Ligonine");
      System.out.println("Galimos ligonines: ");
      for(int i = 0; i < hospitals.size(); i++)
      {
        System.out.println((String) hospitals.get(i).get(0));
      }
    }
    catch(Exception e)
    {
      System.out.println("Error: " + e.getMessage());
    }

    try
    {
      docs = db.queryDb("SELECT * FROM rira1874.Gydytojas");
      System.out.println("Gydytojai: ");
      for(int i = 0; i < docs.size(); i++)
      {
        System.out.println((String) docs.get(i).get(0) + " " + docs.get(i).get(1) + " " + docs.get(i).get(2)
                            + " " + docs.get(i).get(3) + " " + docs.get(i).get(4) + " " + docs.get(i).get(5));
      }

      System.out.println("Iveskite gydytojo nauja darboviete ir asmens koda:");
      docs = db.queryDb("UPDATE rira1874.Gydytojas SET Ligonines_Pavadinimas  = '" + bufRead.readLine() + "' WHERE AK = '" + bufRead.readLine() + "'");
    }
    catch (Exception e)
    {
      System.out.println("Error: " + e.getMessage());
    }
  }
}
