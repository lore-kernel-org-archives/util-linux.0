Return-Path: <SRS0=jsgS=UK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C50EC43218
	for <util-linux@archiver.kernel.org>; Tue, 11 Jun 2019 06:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FB62086D
	for <util-linux@archiver.kernel.org>; Tue, 11 Jun 2019 06:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfFKGaw convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Tue, 11 Jun 2019 02:30:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:17174 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbfFKGaw (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 11 Jun 2019 02:30:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 23:30:52 -0700
X-ExtLoop1: 1
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga004.jf.intel.com with ESMTP; 10 Jun 2019 23:30:52 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 10 Jun 2019 23:30:51 -0700
Received: from fmsmsx119.amr.corp.intel.com ([169.254.14.107]) by
 FMSMSX126.amr.corp.intel.com ([169.254.1.74]) with mapi id 14.03.0415.000;
 Mon, 10 Jun 2019 23:30:51 -0700
From:   "Jakowski, Andrzej" <andrzej.jakowski@intel.com>
To:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [RFC] utility for SED management
Thread-Topic: [RFC] utility for SED management
Thread-Index: AdUgHzTZHbWrG9gFS1SXimdOtclYpQ==
Date:   Tue, 11 Jun 2019 06:30:51 +0000
Message-ID: <548EA37F71F6AC4BB746F459732504FF7F1810E3@FMSMSX119.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWUyYmJiNDItNzljNS00MzM4LWJmYWEtMGYwMDY2MzU4M2IwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTGh4dkNPQjcwQWZPamhqVENKZkoxaUtCeFBEUURXbVIyVE1WSE9vRTh4amlEalZwdythUmF0M0V2Z2piazlBVyJ9
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

As far as I know there is no good utility in open source allowing to manage
Self-Encrypting Drives (SED) for data center scale usages and client usages.

Let me first introduce example use cases for both scenarios: 
 * Data center usages (automatic): when disk is initially provisioned for
   security disk key could be created automatically on key manager and supplied
   to disk. On subsequent reboot of server, when disk is locked, corresponding
   disk key could be retrieved from key manager and used to unlock that disk. 
   Initial provisioning and unlock are example flows which could be automated 
   in the SW.
 * Client usages: manual disk provisioning for security, managing users and
   locking ranges, crypto erase, drive repurposing, etc.

We have built prototype code covering these functionalities and now we would
like to productize it. We are looking for the right place to publish our SW,
considering util-linux project as one of the options. The SW will likely
consist of:
 * Libsed - shared object exposing programmatic interface for security
   management (Opal) of disk
 * Sedcli - command line utility covering both client and data center flows.
   Sedcli will use libsed for interaction with the drive, libkmip for
   interaction with OASIS KMIP based key manager and tpm2-tss to interact with
   TPM2 key manager
 * Udev rules - will be used to invoke sedcli to auto-provision or auto-unlock
   when new device is added to the OS (e.g. hot insert)
 * System.d  scripts - will be used to invoke sedcli when key needs to be 
   retrieved from network attached key manager
 * Config file - will define policies for example on which disk should be 
   security managed or not

We would like to contribute that SW into util-linux project. What do you think
about adding this SW into util-linux?

Thx,
Andrzej

