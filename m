Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23995 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbaEUIYp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 May 2014 04:24:45 -0400
Date: Wed, 21 May 2014 10:24:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org,
        Petr Uzel <petr.uzel@suse.cz>
Subject: Re: [PATCH 0/5] lscpu: improve hypervisor detection
Message-ID: <20140521082437.GC2898@x2.net.home>
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
 <1400603662.5497.86.camel@oct.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400603662.5497.86.camel@oct.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 20, 2014 at 06:34:22PM +0200, Stanislav Brabec wrote:
> Ruediger Meierwrote:
> 
> > I've splitted the original patch into smaller pieces, removed some
> > incompatible output format changes and added some test data.
> 
> There was a controversial part of this patch, that causes test failure.
> 
> There should be a way how to output result of the virtual machine
> detection without breaking test cases (and possibly existing scripts).

Like many other utils we have a way how to specify output columns

  lscpu --extended[=<list>]
  lscpu --parse[=<list>]

The man page:

  -p, --parse[=list]

  If  the  list  argument is omitted, the command output is compatible
  with earlier versions of lscpu. 

it means that HvVendor,VirtType have to be omitted from -p by default.


Frankly, I don't see any practical reason to have hypervisor info in -p
and -e at all. These output formats are about CPU topology and per-CPU
specific information. The global stuff makes more sense for the default
(without options) output where you can use 

    lscpu | awk '/Hypervisor type/ { print $2 }'

or so...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
