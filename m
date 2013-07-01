Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20130701092549.GB28709@x2.net.home>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
	<1371408836-16663-11-git-send-email-kerolasa@iki.fi>
	<20130701092549.GB28709@x2.net.home>
Date: Mon, 1 Jul 2013 11:54:26 +0100
Message-ID: <CAG27Bk0pbXS-GOs4KBFgB9HT72yt8N6943af79rF21ZKnEC1EQ@mail.gmail.com>
Subject: Re: [PATCH 10/15] dmesg: add iso-8601 time format
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 1 July 2013 10:25, Karel Zak <kzak@redhat.com> wrote:
>     dmesg --show-delta --time-format=iso
>
>  is unsupported, right? I have no problem with this restriction, but
>  it would be nice to add some warning to the code.

I agree. Adding a warning is good idea. Unless someone else is quicker
I can do that someday.

--
Sami Kerola
http://www.iki.fi/kerolasa/
