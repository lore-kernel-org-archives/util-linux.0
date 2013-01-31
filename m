Return-Path: bensberg@justemail.net
Message-Id: <1359636926.10683.140661185024845.1F6E77FF@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [patches] adding accents, fixing encodings, and more textual stuff
Date: Thu, 31 Jan 2013 13:55:26 +0100
In-Reply-To: <20130130181927.GH3741@x2.net.home>
References: <1359477853.14228.140661184045573.44739122@webmail.messagingengine.com>
 <20130130181927.GH3741@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 30, 2013, at 19:19, Karel Zak wrote:
> It seems like a problem with
> email encoding, my mutt see the attachments as
> 
>  0001-docs-NEWS-add-some-missing-accents-    [text/x-patch, base64, us-ascii, 6.3K]

I've forwarded the original mail to myself over a different address,
opened it with Thunderbird, saved the attachments -- they come
out fine.  Then I copied the Inbox, opened it with mutt, saved the
attachments -- and they come out mangled.  Mutt replaces every
byte between 80 and ff with a question mark (3f).  Somehow mutt
assumes that what is inside the base64 is or must be us-ascii, and
enforces this when showing and saving the file.  Mutt-bug.

Benno

-- 
http://www.fastmail.fm - Send your email first class
