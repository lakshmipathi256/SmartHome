package com.cdi.smarthome.config;

import org.apache.log4j.Logger;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.web.SpringBootServletInitializer;

import com.amazonaws.services.iot.client.AWSIotException;
import com.amazonaws.services.iot.client.AWSIotMessage;
import com.amazonaws.services.iot.client.AWSIotMqttClient;
import com.amazonaws.services.iot.client.AWSIotQos;
import com.amazonaws.services.iot.client.AWSIotTopic;
import com.cdi.smarthome.AWSconfig.CommandArguments;
import com.cdi.smarthome.AWSconfig.ConnectedWindow;
import com.cdi.smarthome.AWSconfig.SampleUtil;
import com.cdi.smarthome.AWSconfig.SampleUtil.KeyStorePasswordPair;
import com.cdi.smarthome.AWSconfig.TestTopicListener;

/*@author CDI server Team(Basappa and Lakshmi)
*This is main method here our application will start
*
*The <code>@SpringBootApplication<code> annotation is equivalent to using @Configuration, @EnableAutoConfiguration and @ComponentScan with their default attributes:
*
*
*/
@SpringBootApplication(scanBasePackages = "com.cdi.smarthome")
public class Application extends SpringBootServletInitializer {
	private static AWSIotMqttClient awsIotClient;
	private static final String TestTopic = "light";
	private static final AWSIotQos TestTopicQos = AWSIotQos.QOS0;

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);

		final Logger logger = Logger.getLogger(Application.class);

		CommandArguments arguments = CommandArguments.parse(args);
		initClient(arguments);

		try {
			awsIotClient
					.setWillMessage(new AWSIotMessage("client/disconnect", AWSIotQos.QOS0, awsIotClient.getClientId()));
			String thingName = arguments.getNotNull("thingName", SampleUtil.getConfig("thingName"));

			logger.info("AWS THING NAME IS " + thingName);

			ConnectedWindow awsIotDevice = new ConnectedWindow(thingName);
			awsIotClient.attach(awsIotDevice);
			awsIotClient.connect();

			AWSIotTopic topic = new TestTopicListener(TestTopic, TestTopicQos);
			awsIotClient.subscribe(topic, true);

			logger.info("server is connecting to AWS IOT ");

		} catch (AWSIotException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private static void initClient(CommandArguments arguments) {
		final Logger logger = Logger.getLogger(Application.class);
		String clientEndpoint = arguments.getNotNull("clientEndpoint", "a2nqmm3vyiwl6.iot.us-east-1.amazonaws.com");
		String clientId = arguments.getNotNull("clientId", "awsuserclient");

		String certificateFile = arguments.get("certificateFile", SampleUtil.getConfig("certificateFile"));
		String privateKeyFile = arguments.get("privateKeyFile", SampleUtil.getConfig("privateKeyFile"));
		if (awsIotClient == null && certificateFile != null && privateKeyFile != null) {
			String algorithm = arguments.get("keyAlgorithm", SampleUtil.getConfig("keyAlgorithm"));
			KeyStorePasswordPair pair = SampleUtil.getKeyStorePasswordPair(certificateFile, privateKeyFile, algorithm);

			awsIotClient = new AWSIotMqttClient(clientEndpoint, clientId, pair.keyStore, pair.keyPassword);
			logger.info(clientEndpoint + clientId + "for alexa user ");
		}

		if (awsIotClient == null) {
			String awsAccessKeyId = arguments.get("awsAccessKeyId", SampleUtil.getConfig("awsAccessKeyId"));
			String awsSecretAccessKey = arguments.get("awsSecretAccessKey", SampleUtil.getConfig("awsSecretAccessKey"));
			String sessionToken = arguments.get("sessionToken", SampleUtil.getConfig("sessionToken"));

			if (awsAccessKeyId != null && awsSecretAccessKey != null) {
				awsIotClient = new AWSIotMqttClient(clientEndpoint, clientId, awsAccessKeyId, awsSecretAccessKey,
						sessionToken);
			}
		}

		if (awsIotClient == null) {
			throw new IllegalArgumentException("Failed to construct client due to missing certificate or credentials.");
		}
	}

}
