def resultados(file_name)
  file = File.open(file_name, "r")
  alumnos = file.readlines.map(&:chomp).map{ |ele| ele.split(', ')}
  file.close
  return alumnos
end

def promedio_curso(array)
  sum = 0
  str_sum = 0 
  array.each do |ele|
    unless ele.to_i.zero?
      sum += ele.to_i
    else
      str_sum+=1        
    end
  end   
  return sum / (array.length.to_f - str_sum)
end

def asist(array)
  str_sum = 0 
  array.each do |ele|
    if ele.to_i.zero?
      str_sum+=1        
    end
  end   
  return str_sum
end


def alumnos(file_name)
  alumnos = resultados(file_name)
  alumnos.each do |alumno| 
    nombre_alumno = alumno.shift
    promedio = promedio_curso(alumno)
    File.open("notas.txt", "a") { |f| 
      f.puts "#{nombre_alumno}: su promedio en total es #{promedio}" }
  end
  return nil
end


def asistencias(file_name)
  alumnos = resultados(file_name)
  alumnos.each do |alumno| 
    nombre_alumno = alumno.shift
    asistencia = asist(alumno)
    puts "El alumno #{nombre_alumno} tiene un total de #{asistencia} asistencias."
  end
end

def aprobados(file_name, nota=5)
  alumnos = resultados(file_name)
  alumnos.each do |alumno| 
    nombre_alumno = alumno.shift
    promedio = promedio_curso(alumno)
    if promedio > nota
      puts "El alumno #{nombre_alumno} se aprueba con nota #{promedio}"
    end
  end
end


option = gets.chomp

while option != '4'

  puts 'Ingresa 1 para agregar un archivo con los alumnos y sus promedios finales.'
  puts 'Ingresa 2 para ver las asistencias totales por alumno.'
  puts 'Ingresa 3 para ver los alumnos aprobados.'
  puts 'Ingresa 4 para salir.'

  option = gets.chomp
   case  option
    when '1'
      alumnos("file.csv")
      puts 'El archivo se ha creado'
    when '2'
      asistencias("file.csv")
    when '3'
      puts 'Ingresa la nota de aprobación (1 a 10)'
      nota = gets.chomp.to_f
      if nota.zero?
        aprobados("file.csv")
      else
        aprobados("file.csv", nota)      
      end    

    when '4' 
      puts "Adios"
    else
      puts 'La opción no se encuentra. Pone de nuevo la opción 3.' 
    end
end