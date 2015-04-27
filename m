Return-Path: agalakhov@gmail.com
Date: Mon, 27 Apr 2015 23:42:18 +0200
From: Alexey Galakhov <agalakhov@gmail.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] hwclock: flush stdout in hwclock -c
Message-ID: <20150427234218.587e5435.agalakhov@gmail.com>
In-Reply-To: <553EA9AB.1000608@gmx.com>
References: <1429197987-8751-1-git-send-email-agalakhov@gmail.com>
	<20150427082729.GK27969@ws.net.home>
	<553EA9AB.1000608@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Mon, 27 Apr 2015 17:27:07 -0400
J William Piggott <elseifthen@gmx.com> wrote:

> I do not understand what this patch accomplishes. stdout is line
> buffered. All of hwclock -c output ends with \n, which flushes
> the buffer. Then we flush it again with fflush? What am I missing?

stdout is line buffered only if it is not redirected. Using the pipe
symbol in shell to redirect the output i.e. to awk results in not
flushing the buffer until it's full.

A quick test:
$ hwclock -c | cat


Regards,
Alexey
