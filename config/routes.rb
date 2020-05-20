Rails.application.routes.draw do
  devise_for :users

  root 'home#index'
  get '/setup' => 'home#setup', as: 'setup'
  get '/academy' => 'home#academy', as: 'academy'
  get '/registrations' => 'home#registrations', as: 'registrations'

  resources :batches
  resources :subjects

  get '/batches/:id/assign/subjects' => 'batch_subjects#new', as: 'assign_subjects'
  post '/batches/:id/assign/subjects' => 'batch_subjects#create', as: 'batch_subjects'
  delete '/batches/:id/:sub_id/subjects/delete' => 'batch_subjects#destroy', as: 'delete_batch_subject'

  resources :staffs
  resources :students

  get '/staffs/:id/assign/subject' => 'teacher_subjects#new', as: 'assign_subject'
  post '/staffs/:id/assign/subject' => 'teacher_subjects#create', as: 'teacher_subjects'

  get '/batch/subject/:id/assign/staff' => 'teacher_batch_subjects#new', as: 'assign_staff'
  post '/batch/subject/:id/assign/staff' => 'teacher_batch_subjects#create', as: 'teacher_batch_subjects'
  get '/batch/subject/:id/change/staff' => 'teacher_batch_subjects#edit', as: 'change_staff'
  patch '/batch/subject/:id/change/staff' => 'teacher_batch_subjects#update', as: 'teacher_batch_subject'
  delete '/batch/subject/:id/delete' => 'teacher_batch_subjects#destroy', as: 'destroy_teacher_batch_subject'

  get '/academy/classes' => 'home#classes', as: 'class'
  get '/academy/class/:id' => 'home#classstudents', as:'class_students'

  get '/students/:id/assign' => 'student_batches#new', as: 'assign_student'
  post '/students/:id/assign' => 'student_batches#create', as: 'student_batches'
  get '/students/:id/change/class' => 'student_batches#edit', as: 'change_student'
  patch '/students/:id/change/class' => 'student_batches#update', as: 'student_batch'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
