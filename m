Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:56221 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754197Ab2FMOxI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Jun 2012 10:53:08 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id CDCE992706
	for <util-linux@vger.kernel.org>; Wed, 13 Jun 2012 16:53:07 +0200 (CEST)
Message-ID: <4FD8A950.5000906@suse.de>
Date: Wed, 13 Jun 2012 16:53:04 +0200
From: Ludwig Nussel <ludwig.nussel@suse.de>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>
Subject: remove encryption options from mount and losetup?
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Is there any reason to still keep the encryption options in losetup and
mount around? They look entirely useless to me. Even when using passfd
and an external key generation function it's still broken as the key
size is fixed at 32 byte and the last byte is always set to '\0'.
So would a patch that removes encryption support completely be
acceptable?

cu
Ludwig

-- 
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg) 
