<?php
class ImportException extends Exception {}

/**
 * Classe de gestion des imports csv
 *
 * @author quinton
 *
 */
class Importgz
{

    private $separator = ",";

    private array $data = array();

    public $nbcharTruncate = 0;

    /**
     * Init file function
     * Get the first line for header
     *
     * @param string  $filename
     * @param string  $separator
     * @param boolean $utf8_encode
     * @return int : number of lines not empty into the file
     *
     * @throws ImportException
     */
    function initFile($filename, $separator = ",")
    {
        $this->separator = $this->normalizeSeparator($separator);
        $nblines = 0;
        /*
         * File read
         */
        if (!$data = gzfile($filename)) {
            throw new ImportException($filename . " non trouvé ou non lisible");
        }
        foreach ($data as $line) {
            $localArray = explode($this->separator, $line);
            if (count($localArray) > 2) {
                $this->data[] = $localArray;
                $nblines++;
            }
        }
        return $nblines;
    }

    function getData(): array
    {
        return $this->data;
    }

    /**
     * Normalize the separator
     *
     * @param string $separator
     * @return string
     */
    private function normalizeSeparator($separator)
    {
        if ($separator == "tab" || $separator == "t") {
            $separator = "\t";
        } else  if ($separator == "space" || $separator == "espace") {
            $separator = " ";
        } else if ($separator == "comma"  || $separator == "virgule") {
            $separator = ",";
        } else if ($separator == "semicolon" || $separator == "point-virgule") {
            $separator = ";";
        }
        return $separator;
    }
}
