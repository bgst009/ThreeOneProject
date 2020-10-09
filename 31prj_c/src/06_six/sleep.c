double start, stop, durationTime;
main() {
    printf("start\n");
    start = clock();
    sleep(1 * 2);
    stop = clock();
    printf("end\n");
    durationTime = ((double)(stop - start)) / 10;
    printf("duration %lfs", durationTime);
}