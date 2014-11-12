Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f176.google.com ([209.85.217.176]:62877 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbaKLFsR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 12 Nov 2014 00:48:17 -0500
Received: by mail-lb0-f176.google.com with SMTP id 10so8604670lbg.7
        for <util-linux@vger.kernel.org>; Tue, 11 Nov 2014 21:48:15 -0800 (PST)
Received: from [192.168.1.118] ([217.70.122.1])
        by mx.google.com with ESMTPSA id o10sm6473176lal.37.2014.11.11.21.48.14
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Nov 2014 21:48:14 -0800 (PST)
Message-ID: <5462F558.5000602@linux.com>
Date: Wed, 12 Nov 2014 11:51:20 +0600
From: Boris Egorov <egorov@linux.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Coverity Scan analysis report
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello.

It is possible to analyze project using Coverity Scan. I've created a 
project on their website with my clone of util-linux on Github. You can 
see it here: https://scan.coverity.com/projects/3469?tab=overview (I can 
export report if you can't see it).
So, it can be done for the main util-linux Github repo. Coupled with 
Travis CI it can generate regular analysis reports.

-- 
Best Regards,
Boris Egorov

