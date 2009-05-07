Return-Path: util-linux-ng-owner@vger.kernel.org
Received: from cantor.suse.de ([195.135.220.2]:58851 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227AbZEGOn7 (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 7 May 2009 10:43:59 -0400
Received: from relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 6BD60749C2
	for <util-linux-ng@vger.kernel.org>; Thu,  7 May 2009 16:43:59 +0200 (CEST)
Date: Thu, 7 May 2009 16:43:58 +0200
From: Michal Hocko <mhocko@suse.cz>
To: util-linux-ng@vger.kernel.org
Subject: *fdisk doesn't check 2TB boundary
Message-ID: <20090507144358.GE4661@tiehlicka.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux-ng.vger.kernel.org>

[Please CC me as I am not subscribed to the list]

Hi,

we have received report from one of our customers that they have a
problem with sfdisk which doesn't check and shout loudly when 2TB
boundary is crossed when partition is created. This results in silent
ignoring of the new partition.

I have noticed a similar bug report in Debian bugzilla[1] but this one
is silent for more than 4 years.

I do understand that user should know what he is doing when creating a
partion and that msdos partitions are limited to 2TB, but is there any
special reason why this limit is not checked?

---
[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=324525
-- 
Michal Hocko
L3 team 
SUSE LINUX s.r.o.
Lihovarska 1060/12
190 00 Praha 9    
Czech Republic
