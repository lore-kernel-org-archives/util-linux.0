Return-Path: linux-kernel-owner@vger.kernel.org
Date: Thu, 15 Feb 2018 11:21:15 +0100
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Andreas Bombe <aeb@debian.org>, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: Linux & FAT32 label
Message-ID: <20180215102115.hspgnqhm4yhejkts@ws.net.home>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171105130608.5oww3b2fnnrwe7ok@pali>
 <20171109212131.uxraxzwpvrlyfyys@pali>
 <20171119124440.ffxx64zjmwedmtdp@pali>
 <20171120111256.zqvmpzdcf6ncyi5m@ws.net.home>
 <20171126191925.zowfpduhyic5w4n5@pali>
 <20171127121301.b6obxoqr4azm3zvs@ws.net.home>
 <20180214215233.tbcoieywczdwvy37@pali>
 <20180214215430.dunkqhuztyic6tcn@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180214215430.dunkqhuztyic6tcn@pali>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 14, 2018 at 10:54:30PM +0100, Pali Rohár wrote:
> On Wednesday 14 February 2018 22:52:33 Pali Rohár wrote:
> > On Monday 27 November 2017 13:13:01 Karel Zak wrote:
> > > On Sun, Nov 26, 2017 at 08:19:25PM +0100, Pali Rohár wrote:
> > > > On Monday 20 November 2017 12:12:56 Karel Zak wrote:
> > > > > Go ahead and send patch :-) (also with LABEL_FATBOOT=)
> > > > 
> > > > Ok, I prepared patches for util-linux including LABEL_FATBOOT:
> > > > https://github.com/karelzak/util-linux/compare/master...pali:master
> > > 
> > > Seems good. I'll wait for official pull request. Thanks!
> > > 
> > > > I have not created official pull request on github yet as Andreas have
> > > > not decided yet about dosfstools/fatlabel...
> > > 
> > > OK.
> > 
> > Looks like that Andreas is not responding to mailing list, nor to
> > private emails, nor on github for 3-4 months ... I hope he is OK.
> > 
> > But I do not know what happened with dosfstools project now in this
> > case, if it is going to be fixed or not.
> > 
> > I have prepared more patches for dosfstools project, but do not know if
> > I should open new pull requests or wait (how long?) or do something
> > else.
> > 
> > If it helps for somebody, I can create fork of dosfstools project and
> > include there all changes which I have prepared.

I think fork is possible way if you (or someone else) want to maintain
dosfstools. 

Please, try to talk about the current situation with downstream
dosfstools maintainers from Debian, Suse, Fedora/RHEL, Gentoo, ...

It's always good to have support from distros before you fork anything. 
Nobody wants to use unmaintained stuff in distros so I guess you will see
positive feedback.

> > Karel, do you want to create official pull request for above util-linux
> > changes, even without fixes in dosfstools project?

I have no problem with the pull request, but if you want to try to
fork dosfstools I can wait for any conclusion. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
