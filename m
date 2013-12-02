Return-Path: psusi@ubuntu.com
Message-ID: <529C9CFF.5030709@ubuntu.com>
Date: Mon, 02 Dec 2013 09:45:19 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: script input redirection / eof handling
References: <52726756.8060205@ubuntu.com> <20131202123659.GE5572@x2.net.home> <20131202125421.GF5572@x2.net.home>
In-Reply-To: <20131202125421.GF5572@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/2/2013 7:54 AM, Karel Zak wrote:
> Note, that if you want to support this scenario (stdin is not a 
> terminal) then send a patch ;-)

It seems to work fine up until it hits eof, which can also happen on a
tty and you'll get the same bad behavior, so I think refusing to run
on a non tty isn't a proper fix.

>> Yep, I think it would be enough to add
>> 
>> kill(0, SIGTERM);
>> 
>> before done() in doinput() to avoid orphans.

You don't want to just make sure the children die, you want to make
sure that the child sees the eof and capture any final output it may have.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSnJz9AAoJEI5FoCIzSKrw6j0IAKZvkym0kJQfWghombuTnV1z
5FCcWPz3Jyo9V96X+fnD3cXpkkPjIM5ZUIBaRJubUYX65AKebXaXw+FkE9YyXsIR
Jeegewp5IlSlF3zbZzCSUchI/gK0KCHv1yKe21xD20iGAy9MGApXBJszsOaREbU2
nG9mFYwviFDQnURBfwHxvS7Bf4S+6i1wgKeS58EqSeXpMpMDCimTw1/mv8MLnGdS
0nzCrPZvgRZcc2avYPSWYs8ZLtFgu5rDuJ7J9TfEuiEzGWCqlPXQYF1a6nHvpT0W
KSdu+1bzsasdrEXFF6Iai2NvFndg9JXqiLCGfKdELbJayYPjwltOtl41PfalG/w=
=2lT4
-----END PGP SIGNATURE-----
