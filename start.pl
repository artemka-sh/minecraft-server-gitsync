#!/usr/bin/perl
use File::Path;

use strict;
use warnings;
use JSON;


##############################    Settings    #############################

my $jar_path = "IMPORT FROM JSON";     
my $server_folder_name = "IMPORT FROM JSON"; 
my $gitsync = "IMPORT FROM JSON";

sub initVaribles
{
    # Открываем файл для чтения
    my $file = 'settings.json';
    open my $fh, '<', $file or die "Не удалось открыть файл '$file' $!";
    # Читаем содержимое файла
    my $json_text = do { local $/; <$fh> };
    # Закрываем файл
    close $fh;
    # Декодируем JSON данные
    my $data = decode_json($json_text);



    # Доступ к данным
    $jar_path = $data->{'jar_path'};
    $server_folder_name = $data->{'server_folder_name'};
    $gitsync = $data->{'gitsync'};
}

sub setting
{
    # Укажите относительный путь к вашему jar файлу ОТНОСИТЕЛЬНО ПАПКИ СЕРВЕРА
}


#############################    FUNCS      ###############################



sub greeting
{
    print "Hi, this is an automatic deployment program for minecraft server with git synchronization functions";
}




#sub addFile {
#my ($fileName, $content) = @_; 
#    open(my $file, '>', "$fileName") or "Could not open file '$fileName' for writing: $!";
#    print $file "$content";
#    close($file);
#    #return $result; # Возвращаем значение
#}



sub configEula
{
    addFile("eula.txt", "eula=true");
    print("eula is true, nothing to do");


}

sub startServer
{
    if($gitsync == 'true')
    {
        system("git pull");
    }
    chdir($server_folder_name);
    system("java -jar $jar_path");
    if($gitsync == 'true')
    {
        system("git add .");
        system("git commit -m 'server update'");
    }
    
}
############################       RUN      ##############################

greeting();

if(1==1)# have setting file 
{
    initVaribles();
}
#else 
#{
#    #setting process
#}

print "Wanna start server? (y/n): ";
my $input = <STDIN>;
chomp($input); # Удаляем символ новой строки

if ($input eq 'y' or $input eq 'Y') {
    # Запуск сервера
    print "Starting the server...\n";
    startServer();
} else {
    print "Server not started.\n";
}



print "\n Perl is cool? \n";
system("pause");

