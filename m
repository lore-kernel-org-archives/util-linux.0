Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:32824 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0JMP (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Aug 2018 05:12:15 -0400
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id w7R5R9vF099201
        for <util-linux@vger.kernel.org>; Sun, 26 Aug 2018 22:27:11 -0700
Message-ID: <5B838BAE.1010706@tlinx.org>
Date: Sun, 26 Aug 2018 22:27:10 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: why do I get this:/bin/findmnt.suse: /lib64/libsmartcols.so.1: version
 `SMARTCOLS_2.25' not found (required by /bin/findmnt.suse)
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

when smartcols.sym has a whole section with 2.25 syms in it.

What is the point of embedding mixing symbols with versions if they 
don't work?
I.e. the 2.25 version of the symbols is in the lib, but findmnt linked 
against 2.25 doesn't work cuz it can't access that specific label. 
(sources from
2.32.1).  

I don't understand why the symbols are versioned in a library that 
doesn't appear to have anything other than a normal symbol table.

So why are these symbols versioned if they don't work?  They seem to 
prevent earlier versions of programs from working with later libs even 
though they are compatible.
