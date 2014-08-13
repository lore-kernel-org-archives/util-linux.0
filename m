Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:55796 "EHLO
	Ishtar.hs.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbaHMR0H (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 13 Aug 2014 13:26:07 -0400
Message-ID: <53EB9F9F.3020201@tlinx.org>
Date: Wed, 13 Aug 2014 10:25:51 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Stanislav Brabec <sbrabec@suse.cz>
CC: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: util-linux and distro bootstrap, dependencies and build cycles
References: <1407768431.5984.23.camel@oct.suse.cz>	 <20140812093955.GL17719@x2.net.home> <1407874536.5984.80.camel@oct.suse.cz>	 <20140813101736.GO17719@x2.net.home> <1407941620.5984.134.camel@oct.suse.cz>
In-Reply-To: <1407941620.5984.134.camel@oct.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Stanislav Brabec wrote:
> Only base system changes (gcc, binutils, bash, util-linux,...) trigger
> whole distro to rebuild. Updates of high level packages triggers only
> dependent package.
>   
> This prevents any binary incompatibility when releasing rolling update
> with a new library.
>   
----
There are other ways of dealing with binary compatibility.

As it is, if you want to update perl, python, ruby  for example, you need
to rebuild the entire system.

Even vim/Gvim has dependencies on systemd because it supplies config files
that systemd uses.  But worse, if you update perl/python or ruby, you can
no longer edit. 

    It has been pointed to suse, multiple times, that they could build 
most of their
utils with less hard-coded dependencies (like have gvim dynamically load 
script
engines at run time on demand, when needed rather than having to load 
all of them
at load time in order for gvim to run.


    Even when no binary dependencies are  present, hard-coding versions 
and labels into
each of the binaries to only work with recognized components guarantees 
failure on
opensuse systems.  I have pushed for having a more robust system, but 
the current
mantra is "break everything" if the user changes anything ....
