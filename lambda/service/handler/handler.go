package handler

import (
	"github.com/aws/aws-lambda-go/events"
	"log/slog"
	"os"
)

var logger = slog.New(slog.NewJSONHandler(os.Stdout, nil))

func init() {
	logger.Info("init()")
}

func TemplateServiceHandler(request events.APIGatewayV2HTTPRequest) (*events.APIGatewayV2HTTPResponse, error) {
	var err error
	var apiResponse *events.APIGatewayV2HTTPResponse
	logger = logger.With("requestID", request.RequestContext.RequestID)

	logger.Info("TemplateServiceHandler()")
	apiResponse, err = handleRequest()

	return apiResponse, err
}

func handleRequest() (*events.APIGatewayV2HTTPResponse, error) {
	logger.Info("handleRequest()")
	apiResponse := events.APIGatewayV2HTTPResponse{Body: "{'response':'hello'}", StatusCode: 200}

	return &apiResponse, nil
}
