Return-Path: util-linux-owner@vger.kernel.org
Received: from mailrelay4.webfaction.com ([185.20.51.6]:56942 "EHLO
        mailrelay4.webfaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbeHNQFk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Aug 2018 12:05:40 -0400
Received: from mailrelay3.webfaction.com (mailrelay3.webfaction.com [207.38.93.110])
        by mailrelay4.webfaction.com (Postfix) with ESMTPS id 721981204B4
        for <util-linux@vger.kernel.org>; Tue, 14 Aug 2018 13:18:31 +0000 (UTC)
Received: from mailrelay1.webfaction.com (mailrelay1.webfaction.com [207.38.86.46])
        by mailrelay3.webfaction.com (Postfix) with ESMTPS id 012642836CB
        for <util-linux@vger.kernel.org>; Tue, 14 Aug 2018 13:18:30 +0000 (UTC)
Received: from smtp.webfaction.com (mail6.webfaction.com [31.170.123.134])
        by mailrelay1.webfaction.com (Postfix) with ESMTPS id 358F01A0B9D
        for <util-linux@vger.kernel.org>; Tue, 14 Aug 2018 13:18:29 +0000 (UTC)
Received: from [192.168.1.11] (75-131-195-24.dhcp.gwnt.ga.charter.com [75.131.195.24])
        by smtp.webfaction.com (Postfix) with ESMTPSA id 28B286118C495
        for <util-linux@vger.kernel.org>; Tue, 14 Aug 2018 13:18:24 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Edward Diener <eldlistmailingz@tropicsoft.com>
Subject: Using libmount to track mount/umount
Message-ID: <62d391f1-3fd7-1acc-b57e-103a4bbd5244@tropicsoft.com>
Date: Tue, 14 Aug 2018 09:18:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I would like to use the libmount library to track end-user mount/umount 
commands. My first question regards the use of the monitor. What is the 
difference between userspace monitoring and kernel VFS monitoring ?

Edward Diener
