Return-Path: mail@bernhard-voelker.de
Subject: Re: fputs() vs puts()
To: Karel Zak <kzak@redhat.com>, Ruediger Meier <sweet_f_a@gmx.de>
Cc: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
 <201707031030.22137.sweet_f_a@gmx.de>
 <20170703120752.25fkjobw6dxgqo2w@ws.net.home>
 <201707031438.33652.sweet_f_a@gmx.de>
 <20170703142515.rg43rgobwfvykooz@ws.net.home>
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <eb0a5760-7a23-3f2e-e958-ae299711bf0b@bernhard-voelker.de>
Date: Mon, 3 Jul 2017 17:09:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170703142515.rg43rgobwfvykooz@ws.net.home>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

On 07/03/2017 04:25 PM, Karel Zak wrote:
>  after change:
>    -e, --exclude MAJOR     exclude specified devices (see below)

> Objections, comment? 

+1 on the above.

Not to open a can of works, but what about documenting option-arguments
to long options separated with '=' in between?

  PRG --opt LIST ARG
vs.
  PRG --opt=LIST ARG

While getopt_long() supports both, the latters is unambigous with regard
to whether LIST is an argument-option or another argument to the program.
The difference may be important when a program changes an option to
accept option-arguments.

Thanks & have a nice day,
Berny
