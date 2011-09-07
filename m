Return-Path: jacmet@gmail.com
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, kerolasa@iki.fi
Subject: Re: [PATCH] script.c: drop libintl.h include
References: <1315252976-4394-1-git-send-email-jacmet@sunsite.dk>
	<20110907053300.GB2496@nb.redhat.com>
Date: Wed, 07 Sep 2011 13:52:19 +0200
In-Reply-To: <20110907053300.GB2496@nb.redhat.com> (Karel Zak's message of
	"Wed, 7 Sep 2011 07:33:00 +0200")
Message-ID: <877h5klgcs.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <util-linux.vger.kernel.org>

>>>>> "Karel" == Karel Zak <kzak@redhat.com> writes:

 Karel> On Mon, Sep 05, 2011 at 10:02:55PM +0200, Peter Korsgaard wrote:
 >> Commit 8fb810ff26 (script: include-what-you-use header check) added a
 >> <libintl.h> #include, which isn't needed as nls.h includes it (if
 >> enabled) - But worse, breaks the build for systems without libintl.h
 >> (like some uClibc configurations).

 Karel>  Already fixed by patch from Natanael Copa.

Ahh, didn't notice it because of the kernel.org issue. While that patch
also fixes the problem, it is more complicated than needed as nls.h
already includes libintl.h - E.G. the explicit include can just be
removed.

-- 
Bye, Peter Korsgaard
