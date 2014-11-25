Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f181.google.com ([209.85.216.181]:55336 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784AbaKYCRH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 24 Nov 2014 21:17:07 -0500
Received: by mail-qc0-f181.google.com with SMTP id m20so7719804qcx.26
        for <util-linux@vger.kernel.org>; Mon, 24 Nov 2014 18:17:05 -0800 (PST)
Received: from vpn.5665sherbrooke.house ([2001:470:1f07:12d::86b0])
        by mx.google.com with ESMTPSA id 6sm13603394qal.20.2014.11.24.18.17.05
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Nov 2014 18:17:05 -0800 (PST)
Date: Mon, 24 Nov 2014 21:17:04 -0500
From: "SGT. Garcia" <darwinskernel@gmail.com>
To: util-linux@vger.kernel.org
Subject: login: <Enter>/newline acting strange
Message-ID: <20141125021704.GC2488@vpn.5665sherbrooke.house>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

i can bisect this @2.24.2 on gentoo; anything after that, including
building from git, has the same problem. 
tested with fish (the shell).
