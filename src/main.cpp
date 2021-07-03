#include <iostream>

#ifdef NDS
#include <nds.h>
#include <nf_lib.h>
#endif // !NDS

#ifdef WII
#include <stdio.h>
#include <stdlib.h>
#include <gccore.h>
#include <wiiuse/wpad.h>
#endif // WII

void begin() {
#ifdef NDS
	consoleDemoInit();
	consoleClear();
	setBrightness(3, 0);
#endif // NDS

#ifdef WII

	VIDEO_Init();
	WPAD_Init();

	void *framebuffer;
	static GXRModeObj *rmode = VIDEO_GetPreferredMode(NULL);
	framebuffer = MEM_K0_TO_K1(SYS_AllocateFramebuffer(rmode));
	console_init(framebuffer, 20, 20, rmode->fbWidth, rmode->xfbHeight,
				 rmode->fbWidth * VI_DISPLAY_PIX_SZ);

	VIDEO_Configure(rmode);
	VIDEO_SetNextFramebuffer(framebuffer);
	VIDEO_SetBlack(FALSE);
	VIDEO_Flush();
	VIDEO_WaitVSync();
	if (rmode->viTVMode & VI_NON_INTERLACE)
		VIDEO_WaitVSync();

	printf("\x1b[%d;%dH", 2, 0);
#endif // WII
}

void finish() {
#if defined NDS
	while (1)
		swiWaitForVBlank(); // Wait for vertical Blank
#elif defined WII
	while (1) {
		WPAD_ScanPads();
		u32 pressed = WPAD_ButtonsDown(0);
		if (pressed & WPAD_BUTTON_HOME)
			exit(0);

		VIDEO_WaitVSync();
	}
#else
	std::cin.get();
#endif
}

int main() {
	begin();
	std::cout << "Hello World\n";
	finish();
	return 0;
}