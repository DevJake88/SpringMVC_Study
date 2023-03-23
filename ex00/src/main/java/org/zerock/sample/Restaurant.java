package org.zerock.sample;

import org.springframework.stereotype.Component;
import org.springframework.beans.factory.annotation.*;

import lombok.Data;
import lombok.Setter;

@Component
@Data
public class Restaurant {
	@Setter(onMethod_ = @Autowired)
	private Chef chef;
}
