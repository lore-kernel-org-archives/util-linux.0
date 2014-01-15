Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:64202 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbaAOKOP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 15 Jan 2014 05:14:15 -0500
Date: Wed, 15 Jan 2014 11:14:12 +0100
From: Karel <kzak@redhat.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: Regression dump files for discontinuous NUMA nodes
Message-ID: <20140115101412.GK12700@x2.net.home>
References: <52D630F2.5070302@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52D630F2.5070302@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 15, 2014 at 12:25:46PM +0530, Madhavan Srinivasan wrote:
> Attached the foo tgz file that you asked for lscpu regression.

 Thanks! Nice .. 120-CPUs :-)

> Sorry for  the delay was on vacation.

 No problem, tomorrow I found that we have in regression suite a dump from POWER7 with
 3 NUMA nodes where the problem is pretty visible too.

 I'll add your dump to RH bugzilla to test the feature on RHEL7.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
