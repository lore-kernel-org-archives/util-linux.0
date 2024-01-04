Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EA52C687
	for <util-linux@vger.kernel.org>; Thu,  4 Jan 2024 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jLkpwMRF"
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-5eefd0da5c0so9088757b3.2
        for <util-linux@vger.kernel.org>; Thu, 04 Jan 2024 12:10:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704399058; x=1705003858;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViqtSt7j+uXuiETvhByiZRCCTYobsz8jXa9Y5+qqpyY=;
        b=Wy2gBZwfq0/FD7mY2r2rOr7w+6ZkEKmXFWRNVi77mEHqNcmj3VYMNl9V+NpN2S8iC/
         UZGXcktrW1FJJN6U0ee4e8eO5jxyXCWaezuFaDTASVNyEJ0pSkXRJWzudJDOMJ2wg3JJ
         KBUD/kvUMFBtalH2OHmknruStXyfI3fuXKkQOCkXk7rIv9DTn9ZNDiE6taqtIrWqcql5
         POpQCmnp8t8f+/zteV15Px4PGgVXvFMNc+LRwbzPL3Zv8OZ3Wj5L/+eImzypsoSroAnh
         fqELw8gg6ZKHFt/4yIRWIyPNdcTAehH6UMdjJvzlOQE9vZa62Gh2yT0AHnrwAELsKwBc
         ebhA==
X-Gm-Message-State: AOJu0YwiGO3DpoikbjqeHg3jU9vuyngXxVEaKioAaSySdpQXcSfRvcnm
	BhoQW5QfBkfoOMHzXOEvaskUFtmq/vWoT029NEQAf6mwWKjILUF9awA=
X-Google-Smtp-Source: AGHT+IF0Pt/F/eP49oJ9f2frdcDzmL6vf2ZDc0780dR1uhgW3BJDK0r0Ho4dncQkfdG0KH5lCcPPjicwscW6
X-Received: by 2002:a0d:c985:0:b0:5f0:d8f7:f999 with SMTP id l127-20020a0dc985000000b005f0d8f7f999mr1064482ywd.82.1704399057706;
        Thu, 04 Jan 2024 12:10:57 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id r78-20020a819a51000000b005e813ce1ac2sm5486ywg.20.2024.01.04.12.10.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2024 12:10:57 -0800 (PST)
X-Relaying-Domain: arista.com
X-SMTP-Authentication: Allow-List-permitted
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1704399057;
	bh=ViqtSt7j+uXuiETvhByiZRCCTYobsz8jXa9Y5+qqpyY=;
	h=From:To:Cc:Subject:Date:From;
	b=jLkpwMRFtRZc/CPT0AGZoz+NSlzzq5uNITi9bjLyBdKIfjW1xk6oSkU6z0eOubNH2
	 wHHRN9o9oSMD/tKZEcbBYZnD5yT+oujGbQleaK7lcM88PpE7YXN4KMPrVddTdQUGbl
	 MQH9a3Afte7a1e2hkw8BtCL42MNr0RzZX9Mf3UayhaMKgjshfUyZfs9hwkm4XTARHO
	 3IzVRqf6i9xdlwPm39iJfJtgeBhjE4suy0+Xgsc7IMCnIz5WC9FtE29yy4QKaIQxdp
	 +sv6HCJCuykgpT7JQZNo8emo8reE3kyASrAfDCCUy4OgIvQLq+2mJcdgJ5jzi0nZDv
	 XTVQ0BMJ2YuyQ==
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 0DEAB400F82;
	Thu,  4 Jan 2024 12:10:57 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
	id F08E1B84076D; Thu,  4 Jan 2024 12:10:56 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Edward Chron <echron@arista.com>
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
To: util-linux@vger.kernel.org
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Cc: colona@arista.com,
	echron@arista.com,
	echron@gmail.com
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Subject: [PATCH] Add standard dmesg kmsg interface tests Issue: #2663
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Date: Thu,  4 Jan 2024 12:10:55 -0800
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Message-ID: <20240104201055.27160-1-echron@arista.com>
X-SMTP-Authentication: Allow-List-permitted
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>

Submission to Project: util-linux
Open Incident: #2663 at github.com/util-linux/util-linux/issues/2663
Component: util-linux/sys-utils
Files: tests/ts/dmesg kmsg interface files and related expected files
Testing on Fedora 39 with Linux-6.6.6 Kernel and CONFIG_PRINTK_CALLER
config option set.
Patch tested and generated with the latest util-linux code pulled.
Revision: no caller optional fields in any of the kmsg-input entries
Revision: retrofitted to apply on top of Issue: #2609 and Issue #2637
This is patch 1 of 2 (first in the series)
Second patch needed to hold second binary file (git binary files issue)

For issue #2609 Thomas and Zak pointed out the we need tests to verify
that the dmesg command works correctly and to allow us to compare the
results from PRINTK_CALLER id field tests provided by #2609 with the
standard (syslog interface) dmesg tests.

Except for a kmsg json test that Thomas added recently we don't have
basic dmesg tests for the kmsg interface to compare results against.

We added tests for the dmesg SYSLOG PRINTK_CALLER id interface so we
can compare against those tests.
Those tests were submitted with Issue #2637.

Those tests were created before Thomas added the new dmesg kmsg test
and I will rename those tests to match the naming scheme that Thomas
is using for tests that are specific to syslog interface and specific
to kmsg interface.

Issue #2609 introduces dmesg kmsg interface support for the PRINTK_CALLER
id field and provides tests to compare against the SYSLOG interface tests
added by #2637. Those tests also need to renamed to be consistent Thomas's
test naming scheme.

Here we've created tests for the dmesg kmsg interface following the
existing test structure for dmesg tests.

With the addition of this set of tests, we have tests for SYSLOG and
SYSLOG PRINTK_CALLER id field to compare against the kmsg and kmsg
PRINTK_CALLER id field tests.

Currently the only kmsg interface specific test that exists is the
kmsg-file test that Thomas added to test the dmesg kmsg interface for
json support.

Thomas also added code for the -K file interface to process dmesg ksmg
interface files for testing so we utilize that code here and add to it.

The kmsg-input file is expanded to provide statements and fields to
completely test the kmsg interface with tests that are equivalent to the
SYSLOG interface dmesg tests.

Additionally a ksmg-newlines file is added which provides kmsg format
for testing with indentation.

The output of the existing kmsg-file test is adjusted to match the
expanded kmsg-input file.

All tests follow the standard util-linux tests format used by dmesg for
unit tests.

Signed-off-by: Ivan Delalande <colona@arista.com>
Signed-off-by: Edward Chron <echron@arista.com>
---
 tests/expected/dmesg/kmsg-colors         |  45 ++++++++
 tests/expected/dmesg/kmsg-console-levels |  61 +++++++++++
 tests/expected/dmesg/kmsg-decode         |  45 ++++++++
 tests/expected/dmesg/kmsg-delta          |  45 ++++++++
 tests/expected/dmesg/kmsg-facilities     |  59 +++++++++++
 tests/expected/dmesg/kmsg-indentation    |  35 +++++++
 tests/expected/dmesg/kmsg-limit          |  31 ++++++
 tests/ts/dmesg/kmsg-colors               |  29 ++++++
 tests/ts/dmesg/kmsg-console-levels       |  43 ++++++++
 tests/ts/dmesg/kmsg-decode               |  28 +++++
 tests/ts/dmesg/kmsg-delta                |  28 +++++
 tests/ts/dmesg/kmsg-facilities           |  31 ++++++
 tests/ts/dmesg/kmsg-indentation          |  40 +++++++
 tests/ts/dmesg/kmsg-limit                |  29 ++++++
 18 files changed, 663 insertions(+), 17 deletions(-)
 create mode 100644 tests/expected/dmesg/kmsg-colors
 create mode 100644 tests/expected/dmesg/kmsg-console-levels
 create mode 100644 tests/expected/dmesg/kmsg-decode
 create mode 100644 tests/expected/dmesg/kmsg-delta
 create mode 100644 tests/expected/dmesg/kmsg-facilities
 create mode 100644 tests/expected/dmesg/kmsg-indentation
 create mode 100644 tests/expected/dmesg/kmsg-limit
 create mode 100755 tests/ts/dmesg/kmsg-colors
 create mode 100755 tests/ts/dmesg/kmsg-console-levels
 create mode 100755 tests/ts/dmesg/kmsg-decode
 create mode 100755 tests/ts/dmesg/kmsg-delta
 create mode 100755 tests/ts/dmesg/kmsg-facilities
 create mode 100755 tests/ts/dmesg/kmsg-indentation
 create mode 100755 tests/ts/dmesg/kmsg-limit

diff --git a/tests/expected/dmesg/kmsg-colors b/tests/expected/dmesg/kmsg-colors
new file mode 100644
index 000000000..35294c5fa
--- /dev/null
+++ b/tests/expected/dmesg/kmsg-colors
@@ -0,0 +1,45 @@
+kern  :emerg : [32m[    0.000000] [0mLinux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+kern  :alert : [32m[    0.000001] [0m[33mCommand line: [0m[7m[31minitrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system[0m
+kern  :crit  : [32m[    0.000002] [0m[1m[31mBIOS-provided physical RAM map:[0m
+kern  :err   : [32m[    0.000003] [0m[33mBIOS-e820: [0m[31m[mem 0x0000000000000000-0x000000000009efff] usable[0m
+kern  :warn  : [32m[    0.000004] [0m[33mBIOS-e820: [0m[1m[mem 0x000000000009f000-0x00000000000bffff] reserved[0m
+kern  :notice: [32m[    0.000005] [0m[33mBIOS-e820: [0m[mem 0x0000000000100000-0x0000000009afffff] usable
+kern  :info  : [32m[    0.000006] [0m[33mBIOS-e820: [0m[mem 0x0000000009b00000-0x0000000009dfffff] reserved
+kern  :debug : [32m[    0.000007] [0m[33mBIOS-e820: [0m[mem 0x0000000009e00000-0x0000000009efffff] usable
+kern  :info  : [32m[    0.000008] [0m[33mBIOS-e820: [0m[mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+kern  :info  : [32m[    0.000009] [0m[33mBIOS-e820: [0m[mem 0x0000000009f3c000-0x000000004235ffff] usable
+kern  :info  : [32m[    0.000010] [0m[33mBIOS-e820: [0m[mem 0x0000000042360000-0x000000004455ffff] reserved
+kern  :info  : [32m[    0.201607] [0m[33msmp: [0mBringing up secondary CPUs ...
+kern  :info  : [32m[    0.201607] [0m[33msmpboot: [0mx86: Booting SMP configuration:
+kern  :warn  : [32m[    0.209670] [0m[1m  #1  #3  #5  #7[0m
+kern  :info  : [32m[    0.212630] [0m[33msmp: [0mBrought up 1 node, 16 CPUs
+kern  :notice: [32m[    0.215936] [0m[33maudit: [0mtype=2000 audit(1702926179.015:1): state=initialized audit_enabled=0 res=1
+kern  :info  : [32m[    0.215937] [0m[33mthermal_sys: [0mRegistered thermal governor 'fair_share'
+kern  :warn  : [32m[    0.215966] [0m[33mENERGY_PERF_BIAS: [0m[1mSet to 'normal', was 'performance'[0m
+kern  :info  : [32m[    0.367657] [0m[33mACPI: [0m\_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+kern  :info  : [32m[    0.368615] [0m[33mACPI: [0m\_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+kern  :info  : [32m[    0.376316] [0m[33mACPI: [0m\_SB_.PRWL: New power resource
+kern  :info  : [32m[    0.376343] [0m[33mACPI: [0m\_SB_.PRWB: New power resource
+kern  :info  : [32m[    0.377373] [0m[33mACPI: [0mPCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+kern  :info  : [32m[    0.377378] [0m[33macpi PNP0A08:00: [0m_OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+kern  :info  : [32m[    0.377569] [0m[33macpi PNP0A08:00: [0m_OSC: platform does not support [SHPCHotplug AER]
+kern  :info  : [32m[    0.377933] [0m[33macpi PNP0A08:00: [0m_OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+kern  :info  : [32m[    0.378458] [0mPCI host bridge to bus 0000:00
+kern  :info  : [32m[    0.378459] [0m[33mpci_bus 0000:00: [0mroot bus resource [io  0x0000-0x0cf7 window]
+kern  :info  : [32m[    0.378461] [0m[33mpci_bus 0000:00: [0mroot bus resource [io  0x0d00-0xffff window]
+user  :notice: [32m[    9.398562] [0muser network daemon initialization complete
+daemon:info  : [32m[   10.441520] [0m[33msystemd[1]: [0msystemd 254.7-1.fc39 running in system mode
+daemon:info  : [32m[   11.441524] [0m[33msystemd[1]: [0mDetected architecture x86-64.
+daemon:info  : [32m[   12.441525] [0m[33msystemd[1]: [0mRunning in initrd.
+daemon:info  : [32m[   13.541598] [0m[33msystemd[1]: [0mHostname set to <catalina>.
+kern  :info  : [32m[   15.641860] [0m[33musb 3-3: [0mNew USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
+kern  :err   : [32m[   16.690000] [0m[33mSerial bus multi instantiate pseudo device driver INT3515:00: [0m[31merror -ENXIO: IRQ index 1 not found.[0m
+kern  :err   : [32m[   17.710000] [0m[33msnd_hda_intel 0000:00:1f.3: [0m[31mCORB reset timeout#2, CORBRP = 65535[0m
+syslog:info  : [32m[   18.820000] [0m[33msystemd-journald[723]: [0mReceived client request to flush runtime journal.
+syslog:warn  : [32m[   20.840000] [0m[33msystemd-journald[723]: [0m[1mFile /var/log/journal/a124ea923b144109a12d557d5ac53179/system.journal corrupted or uncleanly shut down, renaming and replacing.[0m
+syslog:info  : [32m[   21.852348] [0m[33msystemd-journald[723]: [0m/var/log/journal/ad7a2547ac0e4342a342e62a34a3eae4/user-1000.journal: Journal file uses a different sequence number ID, rotating.
+kern  :warn  : [32m[   24.871100] [0m[33mPEFILE: [0m[1mUnsigned PE binary[0m
+kern  :err   : [32m[   33.918091] [0m[33msnd_hda_intel 0000:00:1f.3: [0m[31mCORB reset timeout#2, CORBRP = 65535[0m
+kern  :info  : [32m[  144.931785] [0m[33musb 3-3.1: [0mdevice firmware changed
+kern  :info  : [32m[  145.953248] [0m[33musb 3-3.1: [0mUSB disconnect, device number 44
+kern  :info  : [32m[  147.981859] [0m[33musb 3-3.1: [0mNew USB device found, idVendor=17ef, idProduct=6047, bcdDevice= 3.30
diff --git a/tests/expected/dmesg/kmsg-console-levels b/tests/expected/dmesg/kmsg-console-levels
new file mode 100644
index 000000000..d48312510
--- /dev/null
+++ b/tests/expected/dmesg/kmsg-console-levels
@@ -0,0 +1,61 @@
+* Output level: err+
+<0>[    0.000000] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+<1>[    0.000001] Command line: initrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system
+<2>[    0.000002] BIOS-provided physical RAM map:
+<3>[    0.000003] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
+<3>[   16.690000] Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: IRQ index 1 not found.
+<3>[   17.710000] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+<3>[   33.918091] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+* Output level: emerg+
+<0>[    0.000000] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+* Output level: +err
+<3>[    0.000003] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
+<4>[    0.000004] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved
+<5>[    0.000005] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
+<6>[    0.000006] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved
+<7>[    0.000007] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
+<6>[    0.000008] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+<6>[    0.000009] BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable
+<6>[    0.000010] BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved
+<6>[    0.201607] smp: Bringing up secondary CPUs ...
+<6>[    0.201607] smpboot: x86: Booting SMP configuration:
+<4>[    0.209670]   #1  #3  #5  #7
+<6>[    0.212630] smp: Brought up 1 node, 16 CPUs
+<5>[    0.215936] audit: type=2000 audit(1702926179.015:1): state=initialized audit_enabled=0 res=1
+<6>[    0.215937] thermal_sys: Registered thermal governor 'fair_share'
+<4>[    0.215966] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
+<6>[    0.367657] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+<6>[    0.368615] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+<6>[    0.376316] ACPI: \_SB_.PRWL: New power resource
+<6>[    0.376343] ACPI: \_SB_.PRWB: New power resource
+<6>[    0.377373] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+<6>[    0.377378] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+<6>[    0.377569] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+<6>[    0.377933] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+<6>[    0.378458] PCI host bridge to bus 0000:00
+<6>[    0.378459] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+<6>[    0.378461] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
+<13>[    9.398562] user network daemon initialization complete
+<30>[   10.441520] systemd[1]: systemd 254.7-1.fc39 running in system mode
+<30>[   11.441524] systemd[1]: Detected architecture x86-64.
+<30>[   12.441525] systemd[1]: Running in initrd.
+<30>[   13.541598] systemd[1]: Hostname set to <catalina>.
+<6>[   15.641860] usb 3-3: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
+<3>[   16.690000] Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: IRQ index 1 not found.
+<3>[   17.710000] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+<46>[   18.820000] systemd-journald[723]: Received client request to flush runtime journal.
+<44>[   20.840000] systemd-journald[723]: File /var/log/journal/a124ea923b144109a12d557d5ac53179/system.journal corrupted or uncleanly shut down, renaming and replacing.
+<46>[   21.852348] systemd-journald[723]: /var/log/journal/ad7a2547ac0e4342a342e62a34a3eae4/user-1000.journal: Journal file uses a different sequence number ID, rotating.
+<4>[   24.871100] PEFILE: Unsigned PE binary
+<3>[   33.918091] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+<6>[  144.931785] usb 3-3.1: device firmware changed
+<6>[  145.953248] usb 3-3.1: USB disconnect, device number 44
+<6>[  147.981859] usb 3-3.1: New USB device found, idVendor=17ef, idProduct=6047, bcdDevice= 3.30
+* Output level: +debug
+<7>[    0.000007] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
+* Output level: notice
+<5>[    0.000005] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
+<5>[    0.215936] audit: type=2000 audit(1702926179.015:1): state=initialized audit_enabled=0 res=1
+<13>[    9.398562] user network daemon initialization complete
+* Output level: +
+test_dmesg: unknown level '+'
diff --git a/tests/expected/dmesg/kmsg-decode b/tests/expected/dmesg/kmsg-decode
new file mode 100644
index 000000000..85a664a61
--- /dev/null
+++ b/tests/expected/dmesg/kmsg-decode
@@ -0,0 +1,45 @@
+kern  :emerg : [    0.000000] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+kern  :alert : [    0.000001] Command line: initrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system
+kern  :crit  : [    0.000002] BIOS-provided physical RAM map:
+kern  :err   : [    0.000003] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
+kern  :warn  : [    0.000004] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved
+kern  :notice: [    0.000005] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
+kern  :info  : [    0.000006] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved
+kern  :debug : [    0.000007] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
+kern  :info  : [    0.000008] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+kern  :info  : [    0.000009] BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable
+kern  :info  : [    0.000010] BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved
+kern  :info  : [    0.201607] smp: Bringing up secondary CPUs ...
+kern  :info  : [    0.201607] smpboot: x86: Booting SMP configuration:
+kern  :warn  : [    0.209670]   #1  #3  #5  #7
+kern  :info  : [    0.212630] smp: Brought up 1 node, 16 CPUs
+kern  :notice: [    0.215936] audit: type=2000 audit(1702926179.015:1): state=initialized audit_enabled=0 res=1
+kern  :info  : [    0.215937] thermal_sys: Registered thermal governor 'fair_share'
+kern  :warn  : [    0.215966] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
+kern  :info  : [    0.367657] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+kern  :info  : [    0.368615] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+kern  :info  : [    0.376316] ACPI: \_SB_.PRWL: New power resource
+kern  :info  : [    0.376343] ACPI: \_SB_.PRWB: New power resource
+kern  :info  : [    0.377373] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+kern  :info  : [    0.377378] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+kern  :info  : [    0.377569] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+kern  :info  : [    0.377933] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+kern  :info  : [    0.378458] PCI host bridge to bus 0000:00
+kern  :info  : [    0.378459] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+kern  :info  : [    0.378461] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
+user  :notice: [    9.398562] user network daemon initialization complete
+daemon:info  : [   10.441520] systemd[1]: systemd 254.7-1.fc39 running in system mode
+daemon:info  : [   11.441524] systemd[1]: Detected architecture x86-64.
+daemon:info  : [   12.441525] systemd[1]: Running in initrd.
+daemon:info  : [   13.541598] systemd[1]: Hostname set to <catalina>.
+kern  :info  : [   15.641860] usb 3-3: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
+kern  :err   : [   16.690000] Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: IRQ index 1 not found.
+kern  :err   : [   17.710000] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+syslog:info  : [   18.820000] systemd-journald[723]: Received client request to flush runtime journal.
+syslog:warn  : [   20.840000] systemd-journald[723]: File /var/log/journal/a124ea923b144109a12d557d5ac53179/system.journal corrupted or uncleanly shut down, renaming and replacing.
+syslog:info  : [   21.852348] systemd-journald[723]: /var/log/journal/ad7a2547ac0e4342a342e62a34a3eae4/user-1000.journal: Journal file uses a different sequence number ID, rotating.
+kern  :warn  : [   24.871100] PEFILE: Unsigned PE binary
+kern  :err   : [   33.918091] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+kern  :info  : [  144.931785] usb 3-3.1: device firmware changed
+kern  :info  : [  145.953248] usb 3-3.1: USB disconnect, device number 44
+kern  :info  : [  147.981859] usb 3-3.1: New USB device found, idVendor=17ef, idProduct=6047, bcdDevice= 3.30
diff --git a/tests/expected/dmesg/kmsg-delta b/tests/expected/dmesg/kmsg-delta
new file mode 100644
index 000000000..caea3e9db
--- /dev/null
+++ b/tests/expected/dmesg/kmsg-delta
@@ -0,0 +1,45 @@
+[    0.000000 <    0.000000>] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+[    0.000001 <    0.000000>] Command line: initrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system
+[    0.000002 <    0.000000>] BIOS-provided physical RAM map:
+[    0.000003 <    0.000000>] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
+[    0.000004 <    0.000000>] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved
+[    0.000005 <    0.000000>] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
+[    0.000006 <    0.000000>] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved
+[    0.000007 <    0.000000>] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
+[    0.000008 <    0.000000>] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+[    0.000009 <    0.000000>] BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable
+[    0.000010 <    0.000000>] BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved
+[    0.201607 <    0.000000>] smp: Bringing up secondary CPUs ...
+[    0.201607 <    0.000000>] smpboot: x86: Booting SMP configuration:
+[    0.209670 <    0.000000>]   #1  #3  #5  #7
+[    0.212630 <    0.000000>] smp: Brought up 1 node, 16 CPUs
+[    0.215936 <    0.000000>] audit: type=2000 audit(1702926179.015:1): state=initialized audit_enabled=0 res=1
+[    0.215937 <    0.000000>] thermal_sys: Registered thermal governor 'fair_share'
+[    0.215966 <    0.000000>] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
+[    0.367657 <    0.000000>] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+[    0.368615 <    0.000000>] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+[    0.376316 <    0.000000>] ACPI: \_SB_.PRWL: New power resource
+[    0.376343 <    0.000000>] ACPI: \_SB_.PRWB: New power resource
+[    0.377373 <    0.000000>] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+[    0.377378 <    0.000000>] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+[    0.377569 <    0.000000>] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+[    0.377933 <    0.000000>] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+[    0.378458 <    0.000000>] PCI host bridge to bus 0000:00
+[    0.378459 <    0.000000>] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+[    0.378461 <    0.000000>] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
+[    9.398562 <    9.000000>] user network daemon initialization complete
+[   10.441520 <    1.000000>] systemd[1]: systemd 254.7-1.fc39 running in system mode
+[   11.441524 <    1.000000>] systemd[1]: Detected architecture x86-64.
+[   12.441525 <    1.000000>] systemd[1]: Running in initrd.
+[   13.541598 <    1.000000>] systemd[1]: Hostname set to <catalina>.
+[   15.641860 <    2.000000>] usb 3-3: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
+[   16.690000 <    1.000000>] Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: IRQ index 1 not found.
+[   17.710000 <    1.000000>] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+[   18.820000 <    1.000000>] systemd-journald[723]: Received client request to flush runtime journal.
+[   20.840000 <    2.000000>] systemd-journald[723]: File /var/log/journal/a124ea923b144109a12d557d5ac53179/system.journal corrupted or uncleanly shut down, renaming and replacing.
+[   21.852348 <    1.000000>] systemd-journald[723]: /var/log/journal/ad7a2547ac0e4342a342e62a34a3eae4/user-1000.journal: Journal file uses a different sequence number ID, rotating.
+[   24.871100 <    3.000000>] PEFILE: Unsigned PE binary
+[   33.918091 <    9.000000>] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+[  144.931785 <  111.000000>] usb 3-3.1: device firmware changed
+[  145.953248 <    1.000000>] usb 3-3.1: USB disconnect, device number 44
+[  147.981859 <    2.000000>] usb 3-3.1: New USB device found, idVendor=17ef, idProduct=6047, bcdDevice= 3.30
diff --git a/tests/expected/dmesg/kmsg-facilities b/tests/expected/dmesg/kmsg-facilities
new file mode 100644
index 000000000..4b460951a
--- /dev/null
+++ b/tests/expected/dmesg/kmsg-facilities
@@ -0,0 +1,59 @@
+dmesg Facility: -1
+dmesg Facility: 0
+[    0.000000] Linux version 6.6.4-arch1-1 (linux@archlinux) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Mon, 04 Dec 2023 00:29:19 +0000
+[    0.000001] Command line: initrd=\ucode.img initrd=\initramfs-linux.img rw cryptdevice=/dev/nvme0n1p3:system:discard root=/dev/mapper/system
+[    0.000002] BIOS-provided physical RAM map:
+[    0.000003] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
+[    0.000004] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved
+[    0.000005] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
+[    0.000006] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reserved
+[    0.000007] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usable
+[    0.000008] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f3bfff] ACPI NVS
+[    0.000009] BIOS-e820: [mem 0x0000000009f3c000-0x000000004235ffff] usable
+[    0.000010] BIOS-e820: [mem 0x0000000042360000-0x000000004455ffff] reserved
+[    0.201607] smp: Bringing up secondary CPUs ...
+[    0.201607] smpboot: x86: Booting SMP configuration:
+[    0.209670]   #1  #3  #5  #7
+[    0.212630] smp: Brought up 1 node, 16 CPUs
+[    0.215936] audit: type=2000 audit(1702926179.015:1): state=initialized audit_enabled=0 res=1
+[    0.215937] thermal_sys: Registered thermal governor 'fair_share'
+[    0.215966] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
+[    0.367657] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+[    0.368615] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+[    0.376316] ACPI: \_SB_.PRWL: New power resource
+[    0.376343] ACPI: \_SB_.PRWB: New power resource
+[    0.377373] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+[    0.377378] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+[    0.377569] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+[    0.377933] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+[    0.378458] PCI host bridge to bus 0000:00
+[    0.378459] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+[    0.378461] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
+[   15.641860] usb 3-3: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
+[   16.690000] Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: IRQ index 1 not found.
+[   17.710000] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+[   24.871100] PEFILE: Unsigned PE binary
+[   33.918091] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+[  144.931785] usb 3-3.1: device firmware changed
+[  145.953248] usb 3-3.1: USB disconnect, device number 44
+[  147.981859] usb 3-3.1: New USB device found, idVendor=17ef, idProduct=6047, bcdDevice= 3.30
+dmesg Facility: 1
+[    9.398562] user network daemon initialization complete
+dmesg Facility: 2
+dmesg Facility: 3
+[   10.441520] systemd[1]: systemd 254.7-1.fc39 running in system mode
+[   11.441524] systemd[1]: Detected architecture x86-64.
+[   12.441525] systemd[1]: Running in initrd.
+[   13.541598] systemd[1]: Hostname set to <catalina>.
+dmesg Facility: 4
+dmesg Facility: 5
+[   18.820000] systemd-journald[723]: Received client request to flush runtime journal.
+[   20.840000] systemd-journald[723]: File /var/log/journal/a124ea923b144109a12d557d5ac53179/system.journal corrupted or uncleanly shut down, renaming and replacing.
+[   21.852348] systemd-journald[723]: /var/log/journal/ad7a2547ac0e4342a342e62a34a3eae4/user-1000.journal: Journal file uses a different sequence number ID, rotating.
+dmesg Facility: 6
+dmesg Facility: 7
+dmesg Facility: 8
+dmesg Facility: 9
+dmesg Facility: 10
+dmesg Facility: 11
+dmesg Facility: 12
diff --git a/tests/expected/dmesg/kmsg-indentation b/tests/expected/dmesg/kmsg-indentation
new file mode 100644
index 000000000..25f41b454
--- /dev/null
+++ b/tests/expected/dmesg/kmsg-indentation
@@ -0,0 +1,35 @@
+[    1.000000] line zero
+[    2.000000] line one
+[    4.000000] line two
+[    7.000000] line three
+[   11.000000] line four
+kern  :notice: [    1.000000] line zero
+user  :crit  : [    2.000000] line one
+mail  :warn  : [    4.000000] line two
+daemon:info  : [    7.000000] line three
+syslog:emerg : [   11.000000] line four
+[<    0.000000>] line zero
+[<    1.000000>] line one
+[<    2.000000>] line two
+[<    3.000000>] line three
+[<    4.000000>] line four
+line zero
+line one
+line two
+line three
+line four
+[Feb13 23:31] line zero
+[  +1.000000] line one
+[  +2.000000] line two
+[  +3.000000] line three
+[  +4.000000] line four
+[Fri Feb 13 23:31:31 2009] line zero
+[Fri Feb 13 23:31:32 2009] line one
+[Fri Feb 13 23:31:34 2009] line two
+[Fri Feb 13 23:31:37 2009] line three
+[Fri Feb 13 23:31:41 2009] line four
+2009-02-13T23:31:31,123456+00:00 line zero
+2009-02-13T23:31:32,123456+00:00 line one
+2009-02-13T23:31:34,123456+00:00 line two
+2009-02-13T23:31:37,123456+00:00 line three
+2009-02-13T23:31:41,123456+00:00 line four
diff --git a/tests/expected/dmesg/kmsg-limit b/tests/expected/dmesg/kmsg-limit
new file mode 100644
index 000000000..0c39b4762
--- /dev/null
+++ b/tests/expected/dmesg/kmsg-limit
@@ -0,0 +1,31 @@
+[    0.201607] smp: Bringing up secondary CPUs ...
+[    0.201607] smpboot: x86: Booting SMP configuration:
+[    0.209670]   #1  #3  #5  #7
+[    0.212630] smp: Brought up 1 node, 16 CPUs
+[    0.215936] audit: type=2000 audit(1702926179.015:1): state=initialized audit_enabled=0 res=1
+[    0.215937] thermal_sys: Registered thermal governor 'fair_share'
+[    0.215966] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
+[    0.367657] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
+[    0.368615] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
+[    0.376316] ACPI: \_SB_.PRWL: New power resource
+[    0.376343] ACPI: \_SB_.PRWB: New power resource
+[    0.377373] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
+[    0.377378] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
+[    0.377569] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER]
+[    0.377933] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
+[    0.378458] PCI host bridge to bus 0000:00
+[    0.378459] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
+[    0.378461] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
+[    9.398562] user network daemon initialization complete
+[   10.441520] systemd[1]: systemd 254.7-1.fc39 running in system mode
+[   11.441524] systemd[1]: Detected architecture x86-64.
+[   12.441525] systemd[1]: Running in initrd.
+[   13.541598] systemd[1]: Hostname set to <catalina>.
+[   15.641860] usb 3-3: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
+[   16.690000] Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: IRQ index 1 not found.
+[   17.710000] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
+[   18.820000] systemd-journald[723]: Received client request to flush runtime journal.
+[   20.840000] systemd-journald[723]: File /var/log/journal/a124ea923b144109a12d557d5ac53179/system.journal corrupted or uncleanly shut down, renaming and replacing.
+[   21.852348] systemd-journald[723]: /var/log/journal/ad7a2547ac0e4342a342e62a34a3eae4/user-1000.journal: Journal file uses a different sequence number ID, rotating.
+[   24.871100] PEFILE: Unsigned PE binary
+[   33.918091] snd_hda_intel 0000:00:1f.3: CORB reset timeout#2, CORBRP = 65535
diff --git a/tests/ts/dmesg/kmsg-colors b/tests/ts/dmesg/kmsg-colors
new file mode 100755
index 000000000..959e7b547
--- /dev/null
+++ b/tests/ts/dmesg/kmsg-colors
@@ -0,0 +1,29 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="kmsg-colors"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+ts_inhibit_custom_colorscheme
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG --color=always -K $TS_SELF/kmsg-input -x >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/kmsg-console-levels b/tests/ts/dmesg/kmsg-console-levels
new file mode 100755
index 000000000..36f8ec097
--- /dev/null
+++ b/tests/ts/dmesg/kmsg-console-levels
@@ -0,0 +1,43 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="kmsg-levels"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+for I in {-1..8}; do
+	$TS_HELPER_DMESG -F $TS_SELF/kmsg-input -l $I >> $TS_OUTPUT 2>/dev/null
+done
+
+echo "* Output level: err+" >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -K $TS_SELF/kmsg-input -r -l err+ >> $TS_OUTPUT 2>/dev/null
+echo "* Output level: emerg+" >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -K $TS_SELF/kmsg-input -r -l emerg+ >> $TS_OUTPUT 2>/dev/null
+echo "* Output level: +err" >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -K $TS_SELF/kmsg-input -r -l +err >> $TS_OUTPUT 2>/dev/null
+echo "* Output level: +debug" >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -K $TS_SELF/kmsg-input -r -l +debug >> $TS_OUTPUT 2>/dev/null
+echo "* Output level: notice" >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -K $TS_SELF/kmsg-input -r -l notice >> $TS_OUTPUT 2>/dev/null
+echo "* Output level: +" >> $TS_OUTPUT 2>/dev/null
+$TS_HELPER_DMESG -K $TS_SELF/kmsg-input -r -l + 2>> $TS_OUTPUT >/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/kmsg-decode b/tests/ts/dmesg/kmsg-decode
new file mode 100755
index 000000000..51fef159d
--- /dev/null
+++ b/tests/ts/dmesg/kmsg-decode
@@ -0,0 +1,28 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="kmsg-decode"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -x -K $TS_SELF/kmsg-input >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/kmsg-delta b/tests/ts/dmesg/kmsg-delta
new file mode 100755
index 000000000..7ae082e76
--- /dev/null
+++ b/tests/ts/dmesg/kmsg-delta
@@ -0,0 +1,28 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="kmsg-delta"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -d -K $TS_SELF/kmsg-input >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/dmesg/kmsg-facilities b/tests/ts/dmesg/kmsg-facilities
new file mode 100755
index 000000000..b274c5de4
--- /dev/null
+++ b/tests/ts/dmesg/kmsg-facilities
@@ -0,0 +1,31 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="kmsg-facilities"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+for I in {-1..12}; do
+        echo "dmesg Facility: $I" >> $TS_OUTPUT
+	$TS_HELPER_DMESG -K $TS_SELF/kmsg-input -f $I >> $TS_OUTPUT 2>/dev/null
+done
+
+ts_finalize
diff --git a/tests/ts/dmesg/kmsg-indentation b/tests/ts/dmesg/kmsg-indentation
new file mode 100755
index 000000000..16870158f
--- /dev/null
+++ b/tests/ts/dmesg/kmsg-indentation
@@ -0,0 +1,40 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="kmsg-indentation"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG -K $TS_SELF/kmsg-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG -K $TS_SELF/kmsg-newlines -x >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=delta --kmsg-file $TS_SELF/kmsg-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=notime --kmsg-file $TS_SELF/kmsg-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=reltime --kmsg-file $TS_SELF/kmsg-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=ctime --kmsg-file $TS_SELF/kmsg-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+$TS_HELPER_DMESG --time-format=iso --kmsg-file $TS_SELF/kmsg-newlines >> $TS_OUTPUT 2>> $TS_ERRLOG
+
+ts_finalize
diff --git a/tests/ts/dmesg/kmsg-limit b/tests/ts/dmesg/kmsg-limit
new file mode 100755
index 000000000..ff70bcf83
--- /dev/null
+++ b/tests/ts/dmesg/kmsg-limit
@@ -0,0 +1,29 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="kmsg-limit"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_DMESG"
+
+export TZ="GMT"
+export DMESG_TEST_BOOTIME="1234567890.123456"
+
+$TS_HELPER_DMESG --since @1234567890.124 --until @1234567991 -K $TS_SELF/kmsg-input \
+	>> $TS_OUTPUT 2> $TS_ERRLOG
+
+ts_finalize
-- 
2.43.0

