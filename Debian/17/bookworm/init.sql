CREATE TEXT SEARCH DICTIONARY english_hunspell (
  TEMPLATE = ispell,
  DictFile = en_us,
  AffFile = en_us,
  StopWords = english
);

COMMENT ON TEXT SEARCH DICTIONARY english_hunspell IS 'hunspell dictionary for english language';

CREATE TEXT SEARCH CONFIGURATION english_hunspell (
  COPY = simple
);

COMMENT ON TEXT SEARCH CONFIGURATION english_hunspell IS 'hunspell configuration for english language';

ALTER TEXT SEARCH CONFIGURATION english_hunspell
ALTER MAPPING FOR asciiword, asciihword, hword_asciipart,
word, hword, hword_part
WITH english_hunspell, english_stem;

CREATE TEXT SEARCH DICTIONARY russian_hunspell (
    TEMPLATE = ispell,
    DictFile = ru_ru,
    AffFile = ru_ru,
    StopWords = russian
);

COMMENT ON TEXT SEARCH DICTIONARY russian_hunspell IS 'hunspell dictionary for russian language';

CREATE TEXT SEARCH CONFIGURATION russian_hunspell (
    COPY = simple
);

COMMENT ON TEXT SEARCH CONFIGURATION russian_hunspell IS 'hunspell configuration for russian language';

ALTER TEXT SEARCH CONFIGURATION russian_hunspell
    ALTER MAPPING FOR asciiword, asciihword, hword_asciipart
    WITH russian_hunspell, english_stem;

ALTER TEXT SEARCH CONFIGURATION russian_hunspell
    ALTER MAPPING FOR word, hword, hword_part
    WITH russian_hunspell, russian_stem;
