Return-Path: jonstanley@gmail.com
MIME-Version: 1.0
In-Reply-To: <20110718091017.GI3486@nb.net.home>
References: <20110705112909.GA3450@osiris.boeblingen.de.ibm.com>
 <20110711104035.GH5214@nb.net.home> <20110713034618.GA2968@osiris.boeblingen.de.ibm.com>
 <20110718091017.GI3486@nb.net.home>
From: Jon Stanley <jonstanley@gmail.com>
Date: Mon, 18 Jul 2011 11:17:24 -0400
Message-ID: <CALY6xnjDxrUWO5su4wqHhwR0=SmZ+bqPVZD1mEqrfRoqSQiV5g@mail.gmail.com>
Subject: Re: [PATCH] lscpu: add support for books
To: Karel Zak <kzak@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 18, 2011 at 5:10 AM, Karel Zak <kzak@redhat.com> wrote:

> =A0I'm not sure if the currently used extra separators (,,) for the
> =A0caches is a good idea. Maybe it would be better to force people to
> =A0parse the last comment line where is the header for the columns.

Speaking as a user of lscpu, I think that forcing people to parse the
last comment line is not a particularly good idea - no one is used to
doing it, and I'm not sure of any other utility that forces you to
parse it's "machine-readable" output. Stability of this format is key.

> =A0The ideal solution is to extend the "-p" functionality and allow to
> =A0specify expected columns at command line, something like:
>
> =A0 =A0lscpu -p -o cpu,core,book,socket

I think that this is the only long-term supportable way to do this.
CPU architectures (even in the x86 world that I'm interested in) ARE
going to change and evolve. Heck, it's even possible that concepts
like the hypervisor scheduling parameters that you mentioned on s390
could eventually make their way down to x86 virtualization, and
exposing stuff like that in lscpu would be nice.
