package com.pluralsight.demo.database;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface DiscountCodeRepository extends JpaRepository<DiscountCode, Integer> {

    Optional<DiscountCode> findByCode(String code);
}
