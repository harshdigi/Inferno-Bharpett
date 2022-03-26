from email import message
from rest_framework.response import Response


class SuccessResponse():

    def __init__(self, message, status=200):
        self.message = message
        self.status = status

    def response(self):
        return Response({
            "error": False,
            "message": self.message,
            "status": self.status
        })


class FailureResponse():

    def __init__(self, message, status=404):
        self.message = message
        self.status = status

    def response(self):
        return Response({
            "error": True,
            "message": self.message,
            "status": self.status
        })