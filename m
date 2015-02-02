Return-Path: bensberg@justemail.net
Message-Id: <1422909749.2945099.222157393.452AAEFB@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: cfdisk's input fields behave awkwardly (in utf8 locale)
Date: Mon, 02 Feb 2015 21:42:29 +0100
In-Reply-To: <20150202121126.GL16162@ws.net.home>
References: <1422799326.1853638.221575473.7DCCA1B0@webmail.messagingengine.com>
 <20150202121126.GL16162@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


On Mon, Feb 2, 2015, at 13:11, Karel Zak wrote:
> On Sun, Feb 01, 2015 at 03:02:06PM +0100, Benno Schulenberg wrote:
> > Anyway, if the cursor keys would not produce weird characters,
> > and they can't be made to work normally (that is: to go left and
> > right), then the only way to change the suggested value is to use
> > the Backspace key.  This is awkward.  The older cfdisk, when it
> 
>  "Fixed" .. I just disable some keys (like left, right...).

Thanks.

You forgot a few "Reported-by:" tags, though.

> > Also, upon startup the old cfdisk would put the cursor on the
> > menu item "Quit", showing the user the most important thing
> > right at the start: how to get out.  This is extra useful when
> > cfdisk is localized to another language where the word for quit
> > doesn't start with a Q.  Could this initial menu-item selection
> > be restored?
> 
>  Fixed.

Nice.  However... when the cursor is moved to a free space, it
would be nice if then automatically the New menu item gets
selected.

Benno

-- 
http://www.fastmail.com - A no graphics, no pop-ups email service
