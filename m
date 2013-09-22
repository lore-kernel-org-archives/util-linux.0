Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <1379821420.2145.50.camel@buesod1.americas.hpqcorp.net>
References: <1379821420.2145.50.camel@buesod1.americas.hpqcorp.net>
Date: Sun, 22 Sep 2013 10:39:40 +0100
Message-ID: <CAG27Bk0eMtYkZdDLVdEjOO+-ZyYOShDDk2mo9_N_qiZCfhB-Jg@mail.gmail.com>
Subject: Re: [PATCH] lscpu: report cpu min mhz
From: Sami Kerola <kerolasa@iki.fi>
To: Davidlohr Bueso <davidlohr@hp.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 22 September 2013 04:43, Davidlohr Bueso <davidlohr@hp.com> wrote:
> The lscpu tool only shows the current and max CPU frequencies, however,
> in many scenarios this is not enough. If there are energy saving situations
> (like some CPUs being idle, or not fully used) the cpugov can lower this value.

Hi Davidlohr,

The patch seems to work as one might expect. Only small thing seems to require
attention, tests broke again. Could you run in util-linux source directory

./tests/run.sh lscpu

and adjust expected outputs accordingly?

Tested-by: Sami Kerola <kerolasa@iki.fi>

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
