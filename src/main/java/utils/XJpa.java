package utils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class XJpa {
	private static EntityManagerFactory factory;
	static {
		factory = Persistence.createEntityManagerFactory("ASM");
	}

	public static EntityManager getEntityManager() {
		return factory.createEntityManager();
	}
	
	public static void main(String[] args) {
		EntityManager em = XJpa.getEntityManager();
		System.out.println("connect");
	}
}
