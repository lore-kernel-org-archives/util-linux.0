Return-Path: util-linux-owner@vger.kernel.org
Received: from message.langara.bc.ca ([142.35.159.25]:64627 "EHLO
	message.langara.bc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbaHRRkU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Aug 2014 13:40:20 -0400
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Received: from langara.bc.ca ([127.0.0.1])
 by message.langara.bc.ca (Sun Java(tm) System Messaging Server 6.3-6.03 (built
 Mar 14 2008; 32bit)) with ESMTP id <0NAI00LHYJR7Z640@message.langara.bc.ca>
 for util-linux@vger.kernel.org; Mon, 18 Aug 2014 10:40:19 -0700 (PDT)
From: Steven Stewart-Gallus <sstewartgallus00@mylangara.bc.ca>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Message-id: <fb47b4bfaf39.53f23a83@langara.bc.ca>
Date: Mon, 18 Aug 2014 17:40:19 +0000 (GMT)
Subject: Re: Utilities don't take into account capabilities
In-reply-to: <3715739.62j44Bg1Aj@vapier>
References: <fbcec6cf5352.53efd3e4@langara.bc.ca> <3715739.62j44Bg1Aj@vapier>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> guessing the sandbox isn't really meant for security purposes since 
> CAP_SYS_ADMIN can easily be used to recover just about every other 
> capability.	http://lwn.net/Articles/486306/

capabilities in a CLONE_NEW_USER sandbox only apply to the sandbox and not
things outside of the sandbox such as devices.
