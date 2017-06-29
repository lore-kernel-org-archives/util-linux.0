Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] misc: standardize USAGE_COLUMNS
Date: Thu, 29 Jun 2017 02:27:35 +0200
Cc: util-linux@vger.kernel.org
References: <1621510c-227f-325b-7867-c305f738174a@gmx.com>
In-Reply-To: <1621510c-227f-325b-7867-c305f738174a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201706290227.35921.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Thursday 29 June 2017 at 00:44, you wrote:


> @@ -101,7 +101,7 @@ static void __attribute__((__noreturn__)) 
usage(void)
>         fputs(USAGE_OPTIONS, stdout);
>         fputs(_(" -J, --json             use JSON output format\n"), 
stdout);
>         fputs(_(" -n, --noheadings       don't print headings\n"), 
stdout);
> -       fputs(_(" -o, --output <list>    define which output columns 
to use\n"), stdout);
> +       fputs(_(" -o, --output <list>    columns to display (see 
Columns:)\n"), stdout);
>         fputs(_(" -r, --raw              use the raw output 
format\n"), stdout);


That's not bad but the standard is IMO to use capital letters
for everthing which is explained below.

This avoids sometimes even the need to explicitly write extra
terms like "see Columns", see:

Options:
 -n, --noheadings       don't print headings
 -o, --output COLUMNS   columns to display
 -r, --raw              use the raw output format
 -h, --help             display this help
 -V, --version          print version

Available output COLUMNS:
     UUID  unique identifier
  VARIANT  variant name
     TYPE  type name
     TIME  timestamp


This is short and easy and quickly to see or search. Anyways
even if you want to keep "see blabla below", BLABLA should be in
capital letters in any case. Compare

$ ls --help | grep SIZE
$ man bash | grep INVOCATION
$ dd --help | grep "\bN\b\|\bBYTES\b"

You see the difference? Imagine if dd would always write
"see BYTES below". That would be pain for the eyes, like
I mentioned in my other email. 

cu,
Rudi
