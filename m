Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34841 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbbIIMMp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Sep 2015 08:12:45 -0400
Received: by wicge5 with SMTP id ge5so152513272wic.0
        for <util-linux@vger.kernel.org>; Wed, 09 Sep 2015 05:12:44 -0700 (PDT)
Message-ID: <55F02239.3090809@plexistor.com>
Date: Wed, 09 Sep 2015 15:12:41 +0300
From: Boaz Harrosh <boaz@plexistor.com>
MIME-Version: 1.0
To: Austin S Hemmelgarn <ahferroin7@gmail.com>,
        "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC: "Knippers, Linda" <linda.knippers@hpe.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        "Kani, Toshimitsu" <toshi.kani@hpe.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>
Subject: Re: mkfs.btrfs cannot find rotational file for SSD detection for
 a pmem device
References: <94D0CD8314A33A4D9D801C0FE68B40295BD1BF1F@G4W3202.americas.hpqcorp.net> <55EEDAE8.1060905@gmail.com> <94D0CD8314A33A4D9D801C0FE68B40295BD1EB13@G4W3202.americas.hpqcorp.net> <55F017CE.1090505@gmail.com>
In-Reply-To: <55F017CE.1090505@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 09/09/2015 02:28 PM, Austin S Hemmelgarn wrote:
> On 2015-09-08 16:00, Elliott, Robert (Persistent Memory) wrote:
<>

> this may actually make things slower (the particular effect of SSD mode 
> is that it tries to spread allocations out as much as possible, as this 
> helps with wear-leveling on many SSD's).
> 

For DRAM based NvDIMM it matters not at all. For Flash based or the new
3d Xpoint it is a plus, so no harm in leaving it in

Just my 1.7 cents
Boaz

