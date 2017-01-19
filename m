Return-Path: util-linux-owner@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:50574 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbdASRDt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 19 Jan 2017 12:03:49 -0500
Date: Thu, 19 Jan 2017 17:53:42 +0100
From: Martin Mares <mj@ucw.cz>
To: util-linux@vger.kernel.org
Subject: Partition alignment in fdisk
Message-ID: <mj+md-20170119.164524.14268.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello, world!\n

Is there any way to override fdisk's default partition
alignment to 1 MB?

On new systems, 1 MB alignment is reasonable, but there are cases where
it is very inconvenient. One such example is when you want to partition
a new disk in the same way as an old one of the same size, like when you
want to add a new disk to an old RAID.

			Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Quote of the day: '
