provider "google" {
  project = "organizacao"
  region  = "us-central1"
  zone    = "us-central1-c"
  credentials = "${file("serviceaccount.yaml")}"
}


resource "google_folder" "Comercial" {
  display_name = "Comercial"
  parent       = "organizations/123456789000"
}

resource "google_folder" "Mobile" {
  display_name = "Mobile"
  parent       = google_folder.Comercial.name
}

resource "google_folder" "Desenvolvimento-Com" {
  display_name = "Desenvolvimento"
  parent       = google_folder.Mobile.name
}

resource "google_folder" "Producao-Com" {
  display_name = "Producao"
  parent       = google_folder.Mobile.name
}


resource "google_folder" "Financeiro" {
  display_name = "Financeiro"
  parent       = "organizations/123456789000"
}

resource "google_folder" "SalesForce" {
  display_name = "SalesForce"
  parent       = google_folder.Financeiro.name
}

resource "google_folder" "Desenvolvimento-Fin" {
  display_name = "Desenvolvimento"
  parent       = google_folder.SalesForce.name
}

resource "google_folder" "Producao-Fin" {
  display_name = "Producao"
  parent       = google_folder.SalesForce.name
}


resource "google_project" "organizacao-comercial-mobile-dev" {
  name       = "Mobile-Dev"
  project_id = "organizacao-comercial-mobile-dev"
  folder_id  = google_folder.Desenvolvimento-Com.name
  auto_create_network=false
  billing_account = "123456-123456-123456"
}

resource "google_project" "organizacao-comercial-mobile-prod" {
  name       = "Mobile-Prod"
  project_id = "organizacao-comercial-mobile-prod"
  folder_id  = google_folder.Producao-Com.name
  auto_create_network=false
  billing_account = "123456-123456-123456"
}


resource "google_project" "organizacao-financeiro-salesforce-dev" {
  name       = "SalesForce-Dev"
  project_id = "organizacao-financeiro-salesforce-dev"
  folder_id  = google_folder.Desenvolvimento-Fin.name
  auto_create_network=false
  billing_account = "123456-123456-123456"
}

resource "google_project" "organizacao-financeiro-salesforce-prod" {
  name       = "SalesForce-Prod"
  project_id = "organizacao-financeiro-salesforce-prod"
  folder_id  = google_folder.Producao-Fin.name
  auto_create_network=false
  billing_account = "123456-123456-123456"
}
