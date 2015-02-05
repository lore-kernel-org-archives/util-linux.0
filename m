Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38361 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750903AbbBEVsb convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Feb 2015 16:48:31 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 37EC920830
	for <util-linux@vger.kernel.org>; Thu,  5 Feb 2015 16:48:31 -0500 (EST)
Message-Id: <1423172910.109711.223698217.4EC40FCF@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <20150204115353.GC1238@ws.net.home>
References: <20150204115353.GC1238@ws.net.home>
Subject: Re: [ANNOUNCE] util-linux v2.26-rc2
Date: Thu, 05 Feb 2015 22:48:30 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Wed, Feb 4, 2015, at 12:53, Karel Zak wrote:
> 
> The util-linux release v2.26-rc2 is available at
> 
>   ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.26

It compiles without error, but shows these warnings along the way:

libfdisk/src/dos.c: In function 'add_partition':
libfdisk/src/dos.c:1204: warning: format '%ju' expects type 'uintmax_t', but argument 4 has type 'long unsigned int'

sys-utils/ipcs.c: In function ‘do_shm’:
sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
sys-utils/ipcs.c:241: warning: dereferencing pointer ‘shm_info’ does break strict-aliasing rules
sys-utils/ipcs.c:223: note: initialized from here

sys-utils/ipcutils.c: In function ‘ipc_shm_get_limits’:
sys-utils/ipcutils.c:92: warning: dereferencing pointer ‘shminfo’ does break strict-aliasing rules
sys-utils/ipcutils.c:91: warning: dereferencing pointer ‘shminfo’ does break strict-aliasing rules
sys-utils/ipcutils.c:90: warning: dereferencing pointer ‘shminfo’ does break strict-aliasing rules
sys-utils/ipcutils.c:89: note: initialized from here

Benno

-- 
http://www.fastmail.com - Access your email from home and the web

