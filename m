Return-Path: util-linux-owner@vger.kernel.org
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:56152 "EHLO
	e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998Ab2HFLuu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Aug 2012 07:50:50 -0400
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Mon, 6 Aug 2012 12:50:48 +0100
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com [9.149.37.249])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q76Boebf27984110
	for <util-linux@vger.kernel.org>; Mon, 6 Aug 2012 11:50:40 GMT
Received: from d06av08.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q76Bok29008532
	for <util-linux@vger.kernel.org>; Mon, 6 Aug 2012 05:50:46 -0600
Date: Mon, 6 Aug 2012 13:50:45 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Faizan husain <faizanh@linux.vnet.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu : -b and -c option does not give expected output.
Message-ID: <20120806114906.GA3432@osiris.de.ibm.com>
References: <1344229852-4737-1-git-send-email-faizanh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1344229852-4737-1-git-send-email-faizanh@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 05, 2012 at 10:10:52PM -0700, Faizan husain wrote:
> From: faizan husain <faizanh@linux.vnet.ibm.com>
> 
> Options for lscpu command are giving incorrect output.
> As per the man page or help, '-b' option should limit the output to online CPUs
> and '-c' option should limit the output to offline CPUs.
> But we could see the output is same for '-a','-b' and '-c' options.
> 
> Signed-off-by: faizan husain <faizanh@linux.vnet.ibm.com>

The -a, -b and -c options were meant to influence the output for the
extended (-e) and parsable (-p) output options.
I'm not sure it makes sense to change the default output with these
options. I'd prefer an update of the man page.

Hm?

