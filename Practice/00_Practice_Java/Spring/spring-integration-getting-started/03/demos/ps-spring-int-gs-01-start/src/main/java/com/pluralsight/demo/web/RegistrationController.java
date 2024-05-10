package com.pluralsight.demo.web;

import com.pluralsight.demo.model.AttendeeRegistration;
import com.pluralsight.demo.service.RegistrationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.validation.Valid;

@Controller
@RequestMapping("/")
public class RegistrationController {
    private static final Logger LOG = LoggerFactory.getLogger(RegistrationController.class);

    private final RegistrationService registrationService;

    public RegistrationController(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }

    @GetMapping
    public String index(@ModelAttribute("registration") AttendeeRegistration registration) {
        return "index";
    }

    @PostMapping
    public String submit(@ModelAttribute("registration") @Valid AttendeeRegistration registration, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            LOG.warn("Validation failed: {}", bindingResult);
            return "index";
        }

        registrationService.register(registration);

        return "success";
    }
}
