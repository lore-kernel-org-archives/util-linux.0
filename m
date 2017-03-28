Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20170328121630.prr5s6aikqvt2awt@ws.net.home>
References: <20170328121630.prr5s6aikqvt2awt@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 28 Mar 2017 22:38:46 +0100
Message-ID: <CAG27Bk2OsrRkvnUZEPjRPVFVgiow2iY4-yCszOU=KAfNYAcX5w@mail.gmail.com>
Subject: Re: col issue
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 28 March 2017 at 13:16, Karel Zak <kzak@redhat.com> wrote:
>  see https://bugzilla.redhat.com/show_bug.cgi?id=1436432
>
>  any idea what is the right col(1) behavior for escape sequences?
>
>  The current code reads two first bytes from the sequence and the rest
>  is interpreted as standard chars (because complex sequences like
>  ^[..m are completely unknown for the code), for example input:
>
>     ^[[1mtomcat-el^[(B^[[m
>
>  produces:
>
>     1mtomcat-elBm
>
>  It seems incorrect. I think for "col -p" all the sequence should be
>  filtered out, it means:
>
>     tomcat-el
>
>  and the default behavior (without -p) should be output all escape
>  sequences but do not increment internal width counters.
>
>  Objections?

This is what Open Group[1] has to say about col(1) input handling.

On input, the only control characters accepted are space, backspace, tab,
carriage-return and newline characters, SI, SO, VT, reverse line-feed,
forward half-line-feed and reverse half-line-feed.  The VT character
is an alternative form of full reverse line-feed, included for
compatibility with some earlier programs of this type.  The only
other characters to be copied to the output are those that are printable.

Last sentence is pretty clear that control characters must be removed.  I am
not sure if the definition was meant to include control sequences, but it
feels that is the spirit of the definition.  Maybe a silly question how to
choose control sequences that are recognised?  Maybe ECMA-48, VT100, and
Unicode.

[1] http://pubs.opengroup.org/onlinepubs/7908799/xcu/col.html

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
