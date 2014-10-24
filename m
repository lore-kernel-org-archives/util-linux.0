Return-Path: bensberg@justemail.net
Message-Id: <1414156721.863715.182864173.3F407ED6@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: JWP <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <544A4497.3010203@gmx.com>
References: <5449BD0F.2070906@gmx.com> <20141024110803.GB10134@x2.net.home>
 <1414151313.843395.182838257.3685FB42@webmail.messagingengine.com>
 <544A4497.3010203@gmx.com>
Subject: Re: [PATCH 0/5] hwclock: clean up messages
Date: Fri, 24 Oct 2014 15:18:41 +0200
List-ID: <util-linux.vger.kernel.org>


On Fri, Oct 24, 2014, at 14:22, JWP wrote:
> I would agree that it should have been named --verbose. However, I 
> have not suggested it because of Util-linux guidelines:
> 
> From util-linux//Documentation/howto-usage-function.txt
> 
> "The rule of thumb with other options is that once they exist, you may
> not change them, nor change how they work, nor remove them."

Sure.  But that does not mean you cannot add a synonym for --debug,
say --verbose, and document it, and undocument the original --debug
(but still recognize it and act upon it, just like in hwclock -v is
still recognized as a synonym of -V).  And then in a couple of years
print a deprecation warning when --debug is used, and then remove it
another two years later.

When you are going to refactor hwclock, many messages are going to
change anyway, and if anyone has become dependent on the --debug
messages, they will have to modify their scripts anyway; it will
then be a small trouble to change --debug to --verbose.  The rule
of thumb is mainly for options that people tend to use in scripts;
you don't want to break those without a very good reason.

Benno

-- 
http://www.fastmail.fm - One of many happy users:
  http://www.fastmail.fm/help/overview_quotes.html
