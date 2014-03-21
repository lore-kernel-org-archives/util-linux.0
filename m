Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53576 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756038AbaCUIRV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 21 Mar 2014 04:17:21 -0400
Date: Fri, 21 Mar 2014 09:17:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Janani Venkataraman <jananive@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, util-linux@vger.kernel.org
Subject: Re: [PATCH 00/33] [RFC] Non disruptive application core dump
 infrastructure
Message-ID: <20140321080855.GE26374@x2.net.home>
References: <20140320093040.14878.903.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140320093040.14878.903.stgit@localhost.localdomain>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 20, 2014 at 03:09:03PM +0530, Janani Venkataraman wrote:
> Gencore Daemon
> 
> The programs can request a dump using gencore() API, provided through
> libgencore. This is implemented through a daemon which listens on a UNIX File
> socket. The daemon is started immediately post installation.

 The gencore command looks like a good idea, but why we need the
 client-server infrastructure? At least at first glance it seems
 like overkill.

> We would like to push this to one of the following packages:
> a) util-linux
> b) coreutils
> c) procps-ng

  d) somewhere near to gdb :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
