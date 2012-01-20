Return-Path: linux-fsdevel-owner@vger.kernel.org
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Karel Zak <kzak@redhat.com>, Attila Kinali <attila@kinali.ch>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Date: Fri, 20 Jan 2012 16:03:42 +0100
Subject: RE: /etc/fstab.d yes or not
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0D8BB2F438@MCHP058A.global-ad.net>
References: <20120120140444.GC13157@x2.net.home>
 <20120120154309.3ae5f9e4a8f55c477dc423ab@kinali.ch>
 <20120120145907.GA20377@x2.net.home>
In-Reply-To: <20120120145907.GA20377@x2.net.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:

> On Fri, Jan 20, 2012 at 03:43:09PM +0100, Attila Kinali wrote:
> > Hence, i would like to ask you to consider not adding /etc/fstab.d
> > unless there is a very good reason to do it. And "to make it simpler
> > for people who have a lot of mountpoints" is IMHO not a good reason.
> > How many mountpoints must one use that a single file becomes a problem?
> 
>  Let's imagine that you have a network and you use the same configuration
>  on all machines, then "*.d/" directories are very useful for you -- for
>  example you can create a company.rpm with important configuration and
>  distribute it to all machines.

Isn't this what the automounter does for decades?

Berny