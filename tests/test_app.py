import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_home_route(client):
    """Test that the home route returns the expected message"""
    response = client.get('/')
    assert response.status_code == 200
    assert b'Hello from Docker!' in response.data

def test_home_route_content(client):
    """Test the exact content of the home route"""
    response = client.get('/')
    assert response.get_data(as_text=True) == 'Hello from Docker!'
